return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "amarakon/nvim-cmp-buffer-lines",
      "hrsh7th/cmp-nvim-lua",
      "dmitmel/cmp-cmdline-history",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require "coding.completion"
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "saadparwaiz1/cmp_luasnip", "honza/vim-snippets" },
    config = function()
      -- bindings live in config/bindings.lua
      require("luasnip.loaders.from_snipmate").lazy_load({
        paths =
        "~/.config/nvim/snippets"
      })
    end
  },
}
