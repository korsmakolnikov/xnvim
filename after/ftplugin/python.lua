vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

-- Converts any leftover tab into spaces on save
local retab_group = vim.api.nvim_create_augroup("PythonRetab", { clear = false })
vim.api.nvim_clear_autocmds({ group = retab_group, buffer = 0 })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = retab_group,
  buffer = 0,
  command = "retab",
  desc = "Convert tabs to spaces when saving Python files",
})
