local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
local function _1_()
  return require("go.format").goimport()
end

vim.api.nvim_create_autocmd("BufWritePre", { callback = _1_, group = format_sync_grp, pattern = "*.go" })
vim.api.nvim_create_autocmd("BufEnter",
  { command = ":set autoindent noexpandtab tabstop=4 shiftwidth=4", pattern = { "*.rs", "*.s", "*.asm", "*.php", "*.py" } })
vim.api.nvim_create_autocmd("BufEnter",
  { command = ":set autoindent noexpandtab tabstop=8 shiftwidth=8", pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.go" } })

local lsp_format_group = vim.api.nvim_create_augroup('my.lsp.format', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),

  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/formatting') then
      -- Drop any handler left over from a previous attach on this buffer so a
      -- server restart cannot stack duplicate format-on-save passes.
      vim.api.nvim_clear_autocmds({ group = lsp_format_group, buffer = args.buf })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = lsp_format_group,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 5000 })
        end,
      })
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


local format_group = vim.api.nvim_create_augroup("AutoRetabPython", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = "*.py", -- Si attiva SOLO sui file Python
  callback = function()
    -- Assicurati che expandtab sia attivo per il buffer corrente
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4

    -- Esegue il retab silenziosamente prima di salvare
    vim.cmd("retab")
  end,
  desc = "Converte automaticamente i tab in spazi salvando file Python",
})
