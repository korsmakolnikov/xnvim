-- Code actions applied on save, before formatting, by server name
local actions_on_save = {
  gopls = "source.organizeImports",
}

local function apply_code_action(client, buf, kind)
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(buf),
    range = {
      start = { line = 0, character = 0 },
      ["end"] = { line = vim.api.nvim_buf_line_count(buf), character = 0 },
    },
    context = { only = { kind }, diagnostics = {} },
  }
  local response = client:request_sync("textDocument/codeAction", params, 3000, buf)
  for _, action in ipairs(response and response.result or {}) do
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end
  end
end

local lsp_format_group = vim.api.nvim_create_augroup('my.lsp.format', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),

  callback = function(args)
    -- Capabilities are not guaranteed to be resolved yet when LspAttach fires,
    -- so the formatting support check is deferred to write time.
    -- Drop any handler left over from a previous attach on this buffer so a
    -- server restart cannot stack duplicate format-on-save passes.
    vim.api.nvim_clear_autocmds({ group = lsp_format_group, buffer = args.buf })

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = lsp_format_group,
      buffer = args.buf,
      desc = 'Format the buffer with any LSP client advertising textDocument/formatting',
      callback = function()
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
          local kind = actions_on_save[client.name]
          if kind and client:supports_method('textDocument/codeAction', args.buf) then
            apply_code_action(client, args.buf, kind)
          end
        end
        vim.lsp.buf.format({
          bufnr = args.buf,
          timeout_ms = 5000,
          filter = function(client)
            return client:supports_method('textDocument/formatting', args.buf)
          end,
        })
      end,
    })

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- LspAttach fires once per client, so a later-attaching server that does
    -- advertise the capability still switches hints on for the buffer.
    if client:supports_method('textDocument/inlayHint', args.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "" then
      return
    end

    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then
      return
    end

    local installed = require("nvim-treesitter.config").get_installed("parsers")
    if not vim.tbl_contains(installed, lang) then
      return
    end

    pcall(vim.treesitter.start, args.buf, lang)
  end,
  desc = "Enable Tree-sitter highlighting whenever a parser is available",
})


vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md,*.vpc,*.txt",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "it" }
    vim.opt_local.textwidth = 80
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.vp",
  callback = function(args)
    require("visual.presentation").start(args.buf)
  end,
})
