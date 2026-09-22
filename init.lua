local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)
-- needed for local .nvim.lua files
vim.o.exrc = true
vim.opt.exrc = true
vim.o.secure = true

require 'packages'
require 'impatient'

vim.g.mapleader = ","
vim.opt.matchpairs = vim.bo.matchpairs .. ",<:>"

local set = vim.opt
set.splitright = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
vim.bo.expandtab = true
vim.wo.wrap = false
set.termguicolors = true
vim.o.cc = '80'
vim.o.virtualedit = 'all'
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.autoindent = true
vim.o.number = true
vim.o.wildmode = 'longest,list'
vim.o.syntax = 'on'
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
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
vim.o.ttyfast = true
vim.o.backupdir = '~/.config/nvim/backup'
vim.o.cmdheight = 3
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.opt.termguicolors = true
vim.g.loaded_python_provider = '0'
vim.g.goyo_width = '80'
vim.g.neovide_fullscreen = true
set.guifont = 'Fira Code Font:h14,Symbols Nerd Font'
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.opt.encoding = "utf-8"
vim.fn.mkdir(vim.fn.stdpath("data") .. "site/spell", "p")
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "it" }
_G.Original_folder = vim.loop.cwd()
-- Tabby options
vim.o.showtabline = 2
vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

-- Parsers kept installed for the languages this configuration targets.
-- The `main` branch of nvim-treesitter has no `ensure_installed` option, so the
-- list is installed explicitly; already installed parsers are skipped.
_G.Treesitter_languages = {
  "asm", "bash", "c", "cmake", "cpp", "eex", "elixir", "elm", "go", "gomod",
  "haskell", "heex", "html", "javascript", "json", "lua", "make", "markdown",
  "markdown_inline", "php", "python", "query", "rust", "toml", "tsx",
  "typescript", "vim", "vimdoc", "yaml",
}

vim.api.nvim_create_user_command("TSEnsureInstalled", function()
  require("nvim-treesitter").install(_G.Treesitter_languages)
end, { desc = "Install every Tree-sitter parser used by this configuration" })

require "visual.theme"
require "neovide"
require "oil_manager"
require "lib"
require "visual.lualine"
require "mason_setup"
require "coding.lsp"
require "coding.dap"
require "coding.autocompletition"
require "markdown"
require "presentation"
require "autogroups"
require "gitlinker".setup()
