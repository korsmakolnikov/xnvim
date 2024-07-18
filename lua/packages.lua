local lazy = require("lazy")
local function _1_()
  local d = require("external_dependencies")
  d.setup()
  return d.lsp()
end

return lazy.setup(
  {
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
    spec = {
      "acro5piano/nvim-format-buffer",
      "udayvir-singh/tangerine.nvim",
      "udayvir-singh/hibiscus.nvim",
      "nvim-lua/plenary.nvim",
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          "folke/neodev.nvim",
          "lvimuser/lsp-inlayhints.nvim",
          "hrsh7th/nvim-cmp",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-cmdline",
          "f3fora/cmp-spell",
          "ray-x/cmp-treesitter",
          "onsails/lspkind.nvim",
          "amarakon/nvim-cmp-buffer-lines",
          "nvim-lua/lsp-status.nvim",
          "hrsh7th/cmp-nvim-lua",
          "dmitmel/cmp-cmdline-history",
          { "antosha417/nvim-lsp-file-operations", config = true } }
      },
      "nvim-treesitter/nvim-treesitter",
      {
        "elixir-tools/elixir-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        tag = "stable",
        config = function()
          local elixir = require("elixir")
          local elixirls = require("elixir.elixirls")

          elixir.setup {
            nextls = { enable = true },
            elixirls = {
              cmd = "elixir-ls",
              enable = true,
              settings = elixirls.settings {
                dialyzerEnabled = true,
                enableTestLenses = false,
                suggestSpecs = true,
              },
              on_attach = function(client, bufnr)
                local wk = require("which-key")
                wk.add({
                  {
                    "<Leader>E",
                    group = "+Elixir",
                    { "<Leader>Ep", ":ElixirFromPipe<cr>",    desc = "From Pipe", },
                    { "<Leader>EP", ":ElixirToPipe<cr>",      desc = "To Pipe", },
                    { "<Leader>Em", ":ElixirExpandMacro<cr>", desc = "Expand Macro", },
                  }
                })
              end,
            },
            projectionist = {
              enable = true
            }
          }
        end
      },
      {
        "folke/which-key.nvim",
        lazy = false,
        event = "VeryLazy",
        opts = {
          preset = "modern"
        }

      },
      { "williamboman/mason.nvim", dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },                                      config = _1_ },
      {
        "terrortylor/nvim-comment",
        config = function()
          require "nvim_comment".setup()
        end
      },
      { "nvim-neotest/neotest",    dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter" } },
      "ray-x/go.nvim",
      "ray-x/guihua.lua",
      "bfredl/nvim-luadev",
      {
        "akinsho/bufferline.nvim",
        config = function()
          require "bufferline".setup()
        end
      },
      "lewis6991/impatient.nvim",
      "stevearc/oil.nvim",
      { "SirZenith/oil-vcs-status", dependencies = { "stevearc/oil.nvim" } },
      { "ruifm/gitlinker.nvim",     dependencies = { "stevearc/oil.nvim" } },
      "tpope/vim-fugitive",
      "kyazdani42/nvim-web-devicons",
      "ryanoasis/vim-devicons",
      "MunifTanjim/nui.nvim",
      "rktjmp/lush.nvim",
      "blueshirts/darcula",
      "rakr/vim-one",
      "navarasu/onedark.nvim",
      { "junegunn/fzf",          build = "./install --bin" },
      "ibhagwan/fzf-lua",
      "junegunn/goyo.vim",
      { "mfussenegger/nvim-dap", dependencies = { "rcarriga/nvim-dap-ui", "mxsdev/nvim-dap-vscode-js" } },
      { "dcampos/nvim-snippy",   dependencies = { "honza/vim-snippets", "dcampos/cmp-snippy" } },
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
        dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
      },
      {
        'freddiehaddad/feline.nvim',
        opts = {},
        config = function()
          require('feline').setup()
        end
      },
      {
        'echasnovski/mini.icons',
        version = false,
        config = function()
          require('mini.icons').setup()
        end
      }
    }
  })
