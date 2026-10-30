return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "mxsdev/nvim-dap-vscode-js" },
    config = function()
      require "coding.dap"
    end
  },
}
