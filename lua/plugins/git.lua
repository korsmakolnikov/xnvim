return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  "tpope/vim-fugitive",
  {
    "ruifm/gitlinker.nvim",
    -- no setup: it would only add its own <Leader>gy, which lives in bindings
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
