local m = {}

function init()
  require("nvim-format-buffer").setup({
    -- If true, print an error message if command fails. default: false
    verbose = false,
    format_rules = {
      { pattern = { "*.fnl" },   command = "fnlfmt -" },
      { pattern = { "*.swift" }, command = "swiftformat --quiet" },
    },
  })
end

m.init = init

require("conform").setup({
  formatters_by_ft = {
    python = { "black" }
  }
})

return m
