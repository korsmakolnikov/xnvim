return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern"
    },
    config = function()
      require "bindings"
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
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
    end
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "SirZenith/oil-vcs-status" },
    config = function()
      require "oil_manager"
    end
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require "nvim_comment".setup()
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  "bfredl/nvim-luadev",
}
