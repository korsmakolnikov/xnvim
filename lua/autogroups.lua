local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
local function _1_()
  return require("go.format").goimport()
end

vim.api.nvim_create_autocmd("BufWritePre", { callback = _1_, group = format_sync_grp, pattern = "*.go" })
vim.api.nvim_create_autocmd("BufEnter",
  { command = ":set autoindent noexpandtab tabstop=4 shiftwidth=4", pattern = { "*.rs", "*.s", "*.asm", "*.php", "*.py" } })
vim.api.nvim_create_autocmd("BufEnter",
  { command = ":set autoindent noexpandtab tabstop=8 shiftwidth=8", pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.go" } })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),

  callback = function(args)
    local opts = { remap = false }
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local builtin = require("telescope.builtin")

    -- along with your other config

    if client:supports_method('textDocument/formatting') then
      -- the most important part
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 5000 })
        end,
      })
    end
  end
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  callback = function(args)
    -- Controlla se Neovim ha un parser Tree-sitter valido per questo tipo di file
    local ft = vim.bo[args.buf].filetype
    local has_parser = pcall(vim.treesitter.get_parser, args.buf, ft)

    if has_parser and ft ~= "" then
      vim.treesitter.start(args.buf)
    end
  end,
})
