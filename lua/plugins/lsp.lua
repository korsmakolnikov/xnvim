return {
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
    config = function()
      require "mason_setup"
    end
  },
  { "ray-x/go.nvim", dependencies = { "ray-x/guihua.lua" } },
}
