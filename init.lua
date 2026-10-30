local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)

require 'config.options'
require 'packages'

_G.Original_folder = vim.loop.cwd()

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
require "mason_setup"
require "coding.lsp"
require "coding.dap"
require "coding.autocompletition"
require "markdown"
require "presentation"
require "autogroups"
require "gitlinker".setup()
