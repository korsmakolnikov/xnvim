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
        'echasnovski/mini.statusline',
        version = '*',
        dependencies = {
          'echasnovski/mini.icons'
        },
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
        "neovim/nvim-lspconfig",
        dependencies = {
          "folke/neodev.nvim",
          "lvimuser/lsp-inlayhints.nvim",
          "hrsh7th/nvim-cmp",
          "hrsh7th/cmp-vsnip",
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
      {
        "nvim-treesitter/nvim-treesitter",
        config = function()
          require 'nvim-treesitter'.setup {
            sync_install = false,
            auto_install = true,
            additional_vim_regex_highlighting = false,
            highlight = { enable = true },
            indent = { enable = true }
          }
        end
      },
      {
        "elixir-tools/elixir-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        version = "*",
        config = function()
          local elixir = require("elixir")
          local elixirls = require("elixir.elixirls")

          elixir.setup {
            nextls = { enable = true },
            elixirls = {
              enable = true,
              settings = elixirls.settings {
                dialyzerEnabled = false,
                fetchDeps = false,
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
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
      },
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
      { "williamboman/mason.nvim", dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" } },
      {
        "terrortylor/nvim-comment",
        config = function()
          require "nvim_comment".setup()
        end
      },
      { "nvim-neotest/neotest",    dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim" } },
      "ray-x/go.nvim",
      "ray-x/guihua.lua",
      "bfredl/nvim-luadev",
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
      { "junegunn/fzf",                build = "./install --bin" },
      "ibhagwan/fzf-lua",
      "junegunn/goyo.vim",
      {
        "mfussenegger/nvim-dap",
        dependencies = { "rcarriga/nvim-dap-ui", "mxsdev/nvim-dap-vscode-js" },
        config = function()
          local dap = require("dap")

          dap.adapters.cppdbg = {
            type = 'executable',
            command = 'OpenDebugAD7',
            name = 'cppdbg',
          }

          dap.configurations.c = {
            {
              name = "Debug",
              type = "cppdbg",
              request = "launch",
              program = function()
                local default_name = 'main'
                local name = vim.fn.input('Name of executable: ', default_name, 'file') -- salva il risultato
                local executable_path = vim.fn.getcwd() .. '/build/' .. name
                return executable_path
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
              args = {},
              setupCommands = {
                {
                  text = '-enable-pretty-printing',
                  description = 'enable pretty printing',
                  ignoreFailures = false
                }
              },
            },
          }

          dap.configurations.cpp = dap.configurations.c
        end
      },
      { "rcarriga/nvim-dap-ui",        config = function() require("dapui").setup() end },
      { "rafamadriz/friendly-snippets" },

      {
        "hrsh7th/vim-vsnip",
        dependencies = { "friendly-snippets" },
        config = function()
          vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
        end,
      },
      {
        'nvim-telescope/telescope.nvim',
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
      {
        'echasnovski/mini.icons',
        version = false,
        config = function()
          require('mini.icons').setup()
        end
      },
      { 'tlaplus-community/tlaplus-nvim-plugin' },
      {
        "susliko/tla.nvim",
        config = function()
          local java_executable = '/usr/bin/java';
          if vim.fn.has('wsl') == 1 then
            java_executable = '/usr/sbin/java'
          end

          require("tla").setup(
            {
              java_executable = java_executable
            }
          )
        end
      },
      {
        'lewis6991/gitsigns.nvim',
        config = function()
          require('gitsigns').setup()
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
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
      }
    }
  })
