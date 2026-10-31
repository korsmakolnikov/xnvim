-- Machine-specific additions, kept out of git in lua/config/local.lua (see the
-- README). The file returns `plugins`, lazy.nvim specs merged with
-- lua/plugins, and `setup`, run after the main configuration; both optional.
local path = vim.fn.stdpath("config") .. "/lua/config/local.lua"
if vim.uv.fs_stat(path) then
  return require("config.local")
end
return {}
