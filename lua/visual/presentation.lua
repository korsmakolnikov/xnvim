-- Presenting mode for *.vp slides: centred, wrapped text, one buffer per slide.
local M = {}

function M.start(buf)
  vim.wo.wrap = true
  vim.wo.number = false
  vim.cmd([[:Goyo 120]])
  require("config.bindings").presentation(buf)
end

return M
