require 'config.options'
require 'config.lazy'

_G.Original_folder = vim.loop.cwd()

require "neovide"
require "lib"
require "coding.lsp"
require "markdown"
require "presentation"
require "autogroups"
