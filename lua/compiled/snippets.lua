-- :fennel:1720867408
return require("snippy").setup({mappings = {is = {["<C-n>"] = "expand_or_advance", ["<C-p>"] = "previous"}}, snippet_dirs = "~/xconf/nvim/snippets"})