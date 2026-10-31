return {
  {
    "williamboman/mason.nvim",
    dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    config = function()
      require "coding.mason"
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
