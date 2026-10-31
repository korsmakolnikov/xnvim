local opt = vim.opt

vim.g.mapleader = ","

-- needed for local .nvim.lua files
opt.exrc = true
opt.secure = true

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- editing
opt.matchpairs:append("<:>")
opt.virtualedit = 'all'
opt.mouse = 'a'
opt.completeopt = 'menuone,noinsert,noselect'
opt.shortmess:append("c")

-- search
opt.hlsearch = true
opt.incsearch = true
opt.wildmode = 'longest,list'

-- ui
opt.termguicolors = true
opt.number = true
opt.wrap = false
opt.colorcolumn = '80'
opt.splitright = true
opt.cmdheight = 3
opt.showtabline = 2 -- always visible, for tabby

-- spell
vim.fn.mkdir(vim.fn.stdpath("data") .. "/site/spell", "p")
opt.spell = true
opt.spelllang = { "en_us", "it" }

opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

opt.clipboard = 'unnamedplus'
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.g.goyo_width = '80'

if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  opt.guifont = 'Fira Code Font:h14,Symbols Nerd Font'
end
