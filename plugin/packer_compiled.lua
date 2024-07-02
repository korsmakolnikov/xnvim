-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/blacksheep/.cache/nvim/packer_hererocks/2.1.1716656478/share/lua/5.1/?.lua;/home/blacksheep/.cache/nvim/packer_hererocks/2.1.1716656478/share/lua/5.1/?/init.lua;/home/blacksheep/.cache/nvim/packer_hererocks/2.1.1716656478/lib/luarocks/rocks-5.1/?.lua;/home/blacksheep/.cache/nvim/packer_hererocks/2.1.1716656478/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/blacksheep/.cache/nvim/packer_hererocks/2.1.1716656478/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-snippy"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-snippy",
    url = "https://github.com/dcampos/cmp-snippy"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  darcula = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/darcula",
    url = "https://github.com/blueshirts/darcula"
  },
  ["elixir-tools.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/elixir-tools.nvim",
    url = "https://github.com/elixir-tools/elixir-tools.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf-lua"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitlinker.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/gitlinker.nvim",
    url = "https://github.com/ruifm/gitlinker.nvim"
  },
  ["go.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lsp-inlayhints.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/lsp-inlayhints.nvim",
    url = "https://github.com/lvimuser/lsp-inlayhints.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nT\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0015\3\3\0B\1\2\1K\0\1\0\1\0\1\vaction\nclose\fexecute\21neo-tree.command\frequire�\21\1\0\a\0A\0a6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\v\0005\3\f\0B\0\3\0016\0\r\0'\2\14\0B\0\2\0029\0\15\0005\2\16\0005\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\3=\3 \0025\3!\0005\4\"\0=\4#\0035\4%\0005\5$\0=\5&\0045\5'\0005\6(\0=\6)\5=\5*\4=\4+\3=\3,\0024\3\0\0=\3-\0025\0032\0005\4.\0004\5\0\0=\5/\0044\5\0\0=\0050\0044\5\0\0=\0051\4=\0043\0035\0045\0005\0054\0=\5+\4=\4,\3=\0036\0025\0037\0005\0049\0005\0058\0=\5+\4=\4,\3=\3:\0025\3<\0005\4;\0004\5\0\0=\5+\4=\4,\3=\3\31\0024\3\3\0005\4=\0003\5>\0=\5?\4>\4\1\3=\3@\2B\0\2\1K\0\1\0\19event_handlers\fhandler\0\1\0\2\fhandler\0\nevent\16file_opened\1\0\1\vwindow\0\1\0\2\rmappings\0\rposition\nfloat\fbuffers\1\0\1\rmappings\0\1\0\3\abd\18buffer_delete\t<bs>\16navigate_up\6.\rset_root\1\0\4\vwindow\0\21group_empty_dirs\2\24follow_current_file\2\18show_unloaded\2\15filesystem\1\0\1\rmappings\0\1\0\t\6f\21filter_on_submit\6H\18toggle_hidden\6/\17fuzzy_finder\t<bs>\16navigate_up\a]g\22next_git_modified\6.\rset_root\a[g\22prev_git_modified\n<c-x>\17clear_filter\6D\27fuzzy_finder_directory\19filtered_items\1\0\6\26hijack_netrw_behavior\17open_default\21group_empty_dirs\1\24follow_current_file\1\19filtered_items\0\vwindow\0\27use_libuv_file_watcher\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\a\fvisible\1\18hide_dotfiles\2\15never_show\0\20hide_by_pattern\0\17hide_by_name\0\16hide_hidden\2\20hide_gitignored\2\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\1\0\badd\vconfig\0\f<space>\1\0\23\6A\18add_directory\6a\0\6C\15close_node\6d\vdelete\6q\17close_window\6z\20close_all_nodes\6x\21cut_to_clipboard\6?\14show_help\6p\25paste_from_clipboard\6c\tcopy\6<\16prev_source\t<cr>\topen\18<2-LeftMouse>\topen\6s\16open_vsplit\f<space>\0\6t\16open_tabnew\6>\16next_source\6R\frefresh\6S\15open_split\6m\tmove\6r\vrename\6w\28open_with_window_picker\6y\22copy_to_clipboard\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\4\20mapping_options\0\nwidth\0032\rmappings\0\rposition\nright\30default_component_configs\15git_status\fsymbols\1\0\1\fsymbols\0\1\0\t\frenamed\b\fdeleted\b✖\nadded\5\rconflict\b\vstaged\b\runstaged\b\rmodified\5\fignored\b\14untracked\b\tname\1\0\3\19trailing_slash\1\14highlight\20NeoTreeFileName\26use_git_status_colors\2\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\5\14highlight\20NeoTreeFileIcon\16folder_open\b\18folder_closed\b\fdefault\6*\17folder_empty\bﰊ\vindent\1\0\t\18indent_marker\b│\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\14highlight\24NeoTreeIndentMarker\22expander_expanded\b\23expander_collapsed\b\23last_indent_marker\b└\14container\1\0\6\tname\0\15git_status\0\vindent\0\rmodified\0\ticon\0\14container\0\1\0\1\26enable_character_fade\2\1\0\f\fbuffers\0\15filesystem\0\18nesting_rules\0\19event_handlers\0\vwindow\0\15git_status\0\30default_component_configs\0\26sort_case_insensitive\1\23enable_diagnostics\2\22enable_git_status\2\25close_if_last_window\1\23popup_border_style\frounded\nsetup\rneo-tree\frequire\1\0\2\ttext\b\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\t \vtexthl\23DiagnosticSignInfo\23DiagnosticSignInfo\1\0\2\ttext\t \vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\t \vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0" },
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neotest = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-cmp-buffer-lines"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-cmp-buffer-lines",
    url = "https://github.com/amarakon/nvim-cmp-buffer-lines"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-vscode-js"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-dap-vscode-js",
    url = "https://github.com/mxsdev/nvim-dap-vscode-js"
  },
  ["nvim-format-buffer"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-format-buffer",
    url = "https://github.com/acro5piano/nvim-format-buffer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-luadev",
    url = "https://github.com/bfredl/nvim-luadev"
  },
  ["nvim-nio"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-nio",
    url = "https://github.com/nvim-neotest/nvim-nio"
  },
  ["nvim-snippy"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-snippy",
    url = "https://github.com/dcampos/nvim-snippy"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { "\27LJ\2\n�\2\0\0\6\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\b\0005\5\a\0=\5\t\0045\5\n\0=\5\v\4=\4\f\3=\3\r\2B\0\2\1K\0\1\0\17filter_rules\abo\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\2\rfiletype\0\fbuftype\0\1\5\0\0\rneo-tree\19neo-tree-popup\vnotify\rquickfix\19filtered_items\1\0\2\abo\0\19filtered_items\0\1\0\1\18hide_dotfiles\1\1\0\3\23other_win_hl_color\f#e35e4f\17filter_rules\0\25close_if_last_window\2\nsetup\18window-picker\frequire\0" },
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  ["oil-vcs-status"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/opt/oil-vcs-status",
    url = "https://github.com/SirZenith/oil-vcs-status"
  },
  ["oil.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["paq-nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/opt/paq-nvim",
    url = "https://github.com/savq/paq-nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-one"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/vim-one",
    url = "https://github.com/rakr/vim-one"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\n\0\0176\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\b\0005\3\a\0=\3\t\2B\0\2\1K\0\1\0\rspelling\1\0\1\rspelling\0\1\0\2\16suggestions\3\20\fenabled\2\nsetup\14which-key\frequire\15timeoutlen\ftimeout\6o\bvim\0" },
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/home/blacksheep/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nT\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0015\3\3\0B\1\2\1K\0\1\0\1\0\1\vaction\nclose\fexecute\21neo-tree.command\frequire�\21\1\0\a\0A\0a6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\v\0005\3\f\0B\0\3\0016\0\r\0'\2\14\0B\0\2\0029\0\15\0005\2\16\0005\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\3=\3 \0025\3!\0005\4\"\0=\4#\0035\4%\0005\5$\0=\5&\0045\5'\0005\6(\0=\6)\5=\5*\4=\4+\3=\3,\0024\3\0\0=\3-\0025\0032\0005\4.\0004\5\0\0=\5/\0044\5\0\0=\0050\0044\5\0\0=\0051\4=\0043\0035\0045\0005\0054\0=\5+\4=\4,\3=\0036\0025\0037\0005\0049\0005\0058\0=\5+\4=\4,\3=\3:\0025\3<\0005\4;\0004\5\0\0=\5+\4=\4,\3=\3\31\0024\3\3\0005\4=\0003\5>\0=\5?\4>\4\1\3=\3@\2B\0\2\1K\0\1\0\19event_handlers\fhandler\0\1\0\2\fhandler\0\nevent\16file_opened\1\0\1\vwindow\0\1\0\2\rmappings\0\rposition\nfloat\fbuffers\1\0\1\rmappings\0\1\0\3\abd\18buffer_delete\t<bs>\16navigate_up\6.\rset_root\1\0\4\vwindow\0\21group_empty_dirs\2\24follow_current_file\2\18show_unloaded\2\15filesystem\1\0\1\rmappings\0\1\0\t\6f\21filter_on_submit\6H\18toggle_hidden\6/\17fuzzy_finder\t<bs>\16navigate_up\a]g\22next_git_modified\6.\rset_root\a[g\22prev_git_modified\n<c-x>\17clear_filter\6D\27fuzzy_finder_directory\19filtered_items\1\0\6\26hijack_netrw_behavior\17open_default\21group_empty_dirs\1\24follow_current_file\1\19filtered_items\0\vwindow\0\27use_libuv_file_watcher\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\a\fvisible\1\18hide_dotfiles\2\15never_show\0\20hide_by_pattern\0\17hide_by_name\0\16hide_hidden\2\20hide_gitignored\2\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\1\0\badd\vconfig\0\f<space>\1\0\23\6A\18add_directory\6a\0\6C\15close_node\6d\vdelete\6q\17close_window\6z\20close_all_nodes\6x\21cut_to_clipboard\6?\14show_help\6p\25paste_from_clipboard\6c\tcopy\6<\16prev_source\t<cr>\topen\18<2-LeftMouse>\topen\6s\16open_vsplit\f<space>\0\6t\16open_tabnew\6>\16next_source\6R\frefresh\6S\15open_split\6m\tmove\6r\vrename\6w\28open_with_window_picker\6y\22copy_to_clipboard\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\4\20mapping_options\0\nwidth\0032\rmappings\0\rposition\nright\30default_component_configs\15git_status\fsymbols\1\0\1\fsymbols\0\1\0\t\frenamed\b\fdeleted\b✖\nadded\5\rconflict\b\vstaged\b\runstaged\b\rmodified\5\fignored\b\14untracked\b\tname\1\0\3\19trailing_slash\1\14highlight\20NeoTreeFileName\26use_git_status_colors\2\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\5\14highlight\20NeoTreeFileIcon\16folder_open\b\18folder_closed\b\fdefault\6*\17folder_empty\bﰊ\vindent\1\0\t\18indent_marker\b│\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\14highlight\24NeoTreeIndentMarker\22expander_expanded\b\23expander_collapsed\b\23last_indent_marker\b└\14container\1\0\6\tname\0\15git_status\0\vindent\0\rmodified\0\ticon\0\14container\0\1\0\1\26enable_character_fade\2\1\0\f\fbuffers\0\15filesystem\0\18nesting_rules\0\19event_handlers\0\vwindow\0\15git_status\0\30default_component_configs\0\26sort_case_insensitive\1\23enable_diagnostics\2\22enable_git_status\2\25close_if_last_window\1\23popup_border_style\frounded\nsetup\rneo-tree\frequire\1\0\2\ttext\b\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\t \vtexthl\23DiagnosticSignInfo\23DiagnosticSignInfo\1\0\2\ttext\t \vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\t \vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-window-picker
time([[Config for nvim-window-picker]], true)
try_loadstring("\27LJ\2\n�\2\0\0\6\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\b\0005\5\a\0=\5\t\0045\5\n\0=\5\v\4=\4\f\3=\3\r\2B\0\2\1K\0\1\0\17filter_rules\abo\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\2\rfiletype\0\fbuftype\0\1\5\0\0\rneo-tree\19neo-tree-popup\vnotify\rquickfix\19filtered_items\1\0\2\abo\0\19filtered_items\0\1\0\1\18hide_dotfiles\1\1\0\3\23other_win_hl_color\f#e35e4f\17filter_rules\0\25close_if_last_window\2\nsetup\18window-picker\frequire\0", "config", "nvim-window-picker")
time([[Config for nvim-window-picker]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\n\0\0176\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\b\0005\3\a\0=\3\t\2B\0\2\1K\0\1\0\rspelling\1\0\1\rspelling\0\1\0\2\16suggestions\3\20\fenabled\2\nsetup\14which-key\frequire\15timeoutlen\ftimeout\6o\bvim\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd oil.nvim ]]
vim.cmd [[ packadd oil-vcs-status ]]
time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
