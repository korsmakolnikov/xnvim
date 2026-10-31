return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern"
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("config.bindings").setup()
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
        },
      })
      telescope.load_extension('fzf')
    end
  },
  -- uses the system fzf binary
  "ibhagwan/fzf-lua",
  {
    "stevearc/oil.nvim",
    dependencies = { "SirZenith/oil-vcs-status" },
    config = function()
      require "explorer"
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  "bfredl/nvim-luadev",
}
