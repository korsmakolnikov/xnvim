-- Widens the leading indentation on screen with inline virtual text. The
-- buffer, and so the file, keeps its real indentation: formatters, LSP and
-- git see the text as it is written.
--
-- Only indentation is widened. A line aligned to something on an earlier
-- line (an argument under an open bracket, the body of a multi-line string
-- or comment) is shifted as much as the line it is aligned to, so the
-- alignment survives. Tree-sitter tells the two apart; without a parser
-- every leading space is widened.
local M = {}

local ns = vim.api.nvim_create_namespace("indent_view")
local debounce_ms = 30
local brackets = { ["("] = true, ["["] = true, ["{"] = true }
local timers = {}

local function indent_width(line, tabstop)
  local width = 0
  for i = 1, #line do
    local c = line:byte(i)
    if c == 32 then
      width = width + 1
    elseif c == 9 then
      width = width + tabstop - width % tabstop
    else
      return width, i - 1
    end
  end
  return width, #line
end

-- Innermost node containing the start of `row` that begins on an earlier line.
local function enclosing(root, row, col)
  local node = root:descendant_for_range(row, col, row, col)
  while node and node:start() >= row do
    node = node:parent()
  end
  return node
end

-- True when the lines inside `node` are aligned rather than indented.
local function is_aligned(node)
  local type = node:type()
  if type:find("string") or type:find("comment") then
    return true
  end
  local open = node:child(0)
  if not (open and brackets[open:type()]) then
    return false
  end
  local next = open:next_sibling()
  -- Content after the bracket on its own line: the rest aligns to it.
  return next ~= nil and next:start() == open:start()
end

local function compute(buf, factor)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local tabstop = vim.bo[buf].tabstop
  local widths, cols = {}, {}
  for row, line in ipairs(lines) do
    widths[row - 1], cols[row - 1] = indent_width(line, tabstop)
  end

  local ok, parser = pcall(vim.treesitter.get_parser, buf)
  local root = ok and parser and parser:parse()[1]:root()

  -- `bases[row]` is the row the indentation of `row` is measured from: the
  -- row itself, or for an aligned row the start of the statement it continues.
  local extras, bases = {}, {}
  local function extra(row)
    if extras[row] then
      return extras[row]
    end
    local value = widths[row] * (factor - 1)
    bases[row] = row
    local node = root and enclosing(root, row, cols[row])
    if node then
      local anchor = node:start()
      if is_aligned(node) then
        value = extra(anchor)
        bases[row] = bases[anchor]
      else
        extra(anchor)
        local base = bases[anchor]
        value = extras[base] + (widths[row] - widths[base]) * (factor - 1)
      end
    end
    extras[row] = math.max(value, 0)
    return extras[row]
  end

  for row = 0, #lines - 1 do
    extra(row)
  end
  return extras
end

local function refresh(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  local factor = vim.b[buf].indent_view_factor
  if not factor then
    return
  end
  local extras = compute(buf, factor)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for row, width in pairs(extras) do
    if width > 0 then
      vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
        virt_text = { { string.rep(" ", width) } },
        virt_text_pos = "inline",
      })
    end
  end
end

-- An edit can move the anchor of any later line, so the whole buffer is
-- recomputed, once per burst of changes.
local function schedule(buf)
  local timer = timers[buf]
  if not timer then
    timer = vim.uv.new_timer()
    timers[buf] = timer
  end
  timer:start(debounce_ms, 0, vim.schedule_wrap(function()
    refresh(buf)
  end))
end

-- Shows the indentation of `buf` `factor` times wider than it is.
function M.enable(buf, factor)
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf
  local attached = vim.b[buf].indent_view_factor ~= nil
  vim.b[buf].indent_view_factor = factor
  refresh(buf)
  if attached then
    return
  end
  vim.api.nvim_buf_attach(buf, false, {
    on_lines = function(_, b)
      schedule(b)
    end,
    on_reload = function(_, b)
      schedule(b)
    end,
    on_detach = function(_, b)
      local timer = timers[b]
      if timer then
        timer:close()
        timers[b] = nil
      end
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(b) then
          vim.b[b].indent_view_factor = nil
        end
      end)
    end,
  })
end

return M
