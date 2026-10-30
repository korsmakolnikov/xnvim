return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "visual.theme"
    end
  },
  {
    'echasnovski/mini.icons',
    version = false,
    config = function()
      require('mini.icons').setup()
    end
  },
  "nvim-tree/nvim-web-devicons",
  {
    'echasnovski/mini.statusline',
    version = '*',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      require('mini.statusline').setup()
    end
  },
  {
    'echasnovski/mini.notify',
    version = '*',
    config = function()
      require('mini.notify').setup()
    end
  },
  {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('tabby').setup()
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          center = {
            {
              icon = '',
              icon_hl = 'group',
              desc = 'description',
              desc_hl = 'group',
              key = 'shortcut key in dashboard buffer not keymap !!',
              key_hl = 'group',
              key_format = ' [%s]', -- `%s` will be substituted with value of `key`
              action = '',
            },
          },
          footer = {},
        }
      }
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "junegunn/goyo.vim",
}
