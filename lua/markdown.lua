local m = {}
m.md_setup = function()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = { "en_us", "it" }
  vim.opt_local.textwidth = 80
end
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md,*.vpc,*.txt",
  callback = m.md_setup
})
