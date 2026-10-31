require 'config.options'
require 'config.lazy'

_G.Original_folder = vim.loop.cwd()

require 'config.util'
require 'config.autocmds'
require 'coding.lsp'
