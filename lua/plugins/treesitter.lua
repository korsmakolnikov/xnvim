-- Parsers kept installed for the languages this configuration targets.
-- The `main` branch of nvim-treesitter has no `ensure_installed` option, so the
-- list is installed explicitly; already installed parsers are skipped.
local languages = {
  "asm", "bash", "c", "cmake", "cpp", "eex", "elixir", "elm", "go", "gomod",
  "haskell", "heex", "html", "javascript", "json", "lua", "make", "markdown",
  "markdown_inline", "php", "python", "query", "rust", "toml", "tsx",
  "typescript", "vim", "vimdoc", "yaml",
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath('data') .. '/site'
      }

      vim.api.nvim_create_user_command("TSEnsureInstalled", function()
        require("nvim-treesitter").install(languages)
      end, { desc = "Install every Tree-sitter parser used by this configuration" })
    end
  },
}
