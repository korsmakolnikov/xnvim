-- Neovide
if vim.g.neovide then
  --Put anything you want to happen only in Neovide here
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.opt.guifont = 'Fira Code Font:h14,Symbols Nerd Font'
  vim.cmd([[
    map! <C-S-v> <C-R>+
  ]])
end
