return {
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
    config = function()
      require "coding.mason"
    end
  },
  { "ray-x/go.nvim", dependencies = { "ray-x/guihua.lua" } },
}
