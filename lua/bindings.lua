local wk = require("which-key")
local dap = {
  toggle_breakpoint = function()
  end,
  continue = function()
  end
}
wk.add(
  {
    {
      "<Leader>C",
      group = "+Configuration",
      { "<Leader>Co", ":e $MYVIMRC<CR>", desc = "Open init.lua", },
    },
    {
      "<Leader>S",
      group = "+Snippy",
      { "<Leader>Sy", "<plug>(snippy-cut-text)", desc = "cut text", },
    },
    {
      "<Leader>b",
      group = "+Buffer",
      { "<Leader>bd", ":bd<CR>", desc = "Delete", },
    },
    {
      "<Leader>c",
      group = "+Fzf Commands",
      { "<Leader>ca", ":FzfLua args<CR>", desc = "Find args" }
    },
    {
      "<Leader>R",
      group = "+Fzf-lua",
      { "<Leader>Rd", ":FzfLua deregister_ui_select<CR>", desc = "De-register fzf-lua with vim.ui.select" },
      { "<Leader>Rr", ":FzfLua register_ui_select<CR>",   desc = "Register fzf-lua as UI Interface for vim.ui.select" }
    },
    {
      "<Leader>c",
      group = "+Locations & lines",
      { "<Leader>cb", ":FzfLua buffers<CR>",  desc = "Find buffers" },
      { "<Leader>cf", ":FzfLua files<CR>",    desc = "Find files" },
      { "<Leader>ch", ":FzfLua oldfiles<CR>", desc = "Find in history" },
      {
        "<Leader>cl",
        group = "+Locations & lines",
        { "<Leader>clb", ":FzfLua blines<CR>",        desc = "Find better lines" },
        { "<Leader>cli", ":FzfLua lines<CR>",         desc = "Find lines" },
        { "<Leader>cll", ":FzfLua loclist<CR>",       desc = "Find location" },
        { "<Leader>cls", ":FzfLua loclist_stack<CR>", desc = "Find location stack" }
      },
      {
        "<Leader>cq",
        group = "Quickfix",
        { "<Leader>cqq", ":FzfLua quickfix<CR>",       desc = "Find quickfix" },
        { "<Leader>cqs", ":FzfLua quickfix_stack<CR>", desc = "Find quickfix stack" }
      },
      { "<Leader>ct", ":FzfLua tabs<CR>", desc = "Find tabs" }
    },
    {
      "<Leader>d",
      group = "+DAP",
      { "<Leader>dB", dap.toggle_breakpoint(),             desc = "Toggle breakpoint" },
      { "<Leader>dC", dap.continue(),                      desc = "Dap continue" },
      { "<Leader>dR", ":lua require'dap'.repl.open()<CR>", desc = "REPL" },
      { "<Leader>db", ":FzfLua dap_breakpoints<CR>",       desc = "List breakpoints" },
      { "<Leader>dc", ":FzfLua dap_commands<CR>",          desc = "DAP commands" },
      { "<Leader>df", ":FzfLua dap_frames<CR>",            desc = "Active session jump to frame" },
      { "<Leader>do", ":FzfLua dap_configurations<CR>",    desc = "DAP configurations" },
      { "<Leader>dv", ":FzfLua dap_variables<CR>",         desc = "Active session variables" }
    },
    {
      "<Leader>g",
      group = "+Git",
      { "<Leader>gC", ":FzfLua git_bcommits<CR>", desc = "Commits buffer" },
      { "<Leader>gS", ":FzfLua git_stash<CR>",    desc = "Stash" },
      { "<Leader>gb", ":FzfLua git_branches<CR>", desc = "Branches" },
      { "<Leader>gc", ":FzfLua git_commits<CR>",  desc = "Commits project" },
      { "<Leader>gf", ":FzfLua git_files<CR>",    desc = "Find versioned files" },
      { "<Leader>gs", ":FzfLua git_status<CR>",   desc = "Status" },
      { "<Leader>gt", ":FzfLua git_tags<CR>",     desc = "Tags" },
      {
        "<Leader>gy",
        "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        desc = "Gitlinker"
      }
    },
    {
      "<Leader>s",
      group = "+Search",
      { "<C-l>", ":lua require('fzf-lua').files({ resume = true })<CR>", desc = "Resume file search" },
      { "<C-s>", ":FzfLua grep_cword<CR>",                               desc = "Grep word under cursor" },
      {
        "<Leader>sG",
        group = "+Grep",
        { "<Leader>sGC", ":FzfLua lgrep_curbuf<CR>", desc = "LGrep current buffer" },
        { "<Leader>sGW", ":FzfLua grep_cWORD<CR>",   desc = "Grep WORD under cursor" },
        { "<Leader>sGc", ":FzfLua grep_curbuf<CR>",  desc = "Grep current buffer" },
        { "<Leader>sGg", ":FzfLua grep<CR>",         desc = "Grep" },
        { "<Leader>sGl", ":FzfLua grep_last<CR>",    desc = "Grep resume" },
        { "<Leader>sGp", ":FzfLua grep_project<CR>", desc = "Grep project" },
        { "<Leader>sGv", ":FzfLua grep_visual<CR>",  desc = "Visual grep" },
        { "<Leader>sGw", ":FzfLua grep_cword<CR>",   desc = "Grep word under cursor" }
      },
      { "<Leader>sb", ":FzfLua live_grep_glob<CR>",   desc = "Live grep glob" },
      { "<Leader>sg", ":FzfLua live_grep<CR>",        desc = "Live grep project" },
      { "<Leader>sn", ":FzfLua live_grep_native<CR>", desc = "Live grep native" },
      { "<Leader>sr", ":FzfLua live_grep_resume<CR>", desc = "Live grep resume" }
    },
    {
      "<Leader>T",
      group = "+Tags",
      { "<Leader>TSW", ":FzfLua tags_grep_cWORD<CR>", desc = "Grep WORD under cursor" },
      { "<Leader>TSp", ":FzfLua tags_grep<CR>",       desc = "Grep project tags" },
      { "<Leader>TSw", ":FzfLua tags_grep_cword<CR>", desc = "Grep word under cursor" },
      { "<Leader>Tb",  ":FzfLua btags<CR>",           desc = "Find tags buffer" },
      { "<Leader>Tg",  ":FzfLua tags_live_grep<CR>",  desc = "Live grep" },
      { "<Leader>Tp",  ":FzfLua tags<CR>",            desc = "Find tags project" }
    },
    {
      "<Leader>l",
      group = "+LSP",
      { "<Leader>lD", ":FzfLua lsp_declarations<CR>",                    desc = "Find declaration" },
      { "<Leader>lF", ":lua vim.lsp.buf.formatting_sync(nil, 5001)<CR>", desc = "Sync buffer format" },
      { "<Leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>",               desc = "Rename symbol" },
      { "<Leader>lS", ":FzfLua lsp_workspace_symbols<CR>",               desc = "Find Workspace symbols" },
      { "<Leader>la", ":FzfLua lsp_code_actions<CR>",                    desc = "Find code actions" },
      {
        "<Leader>lc",
        group = "+Calls",
        { "<Leader>lci", ":FzfLua lsp_incoming_calls<CR>", desc = "Incoming calls" },
        { "<Leader>lco", ":FzfLua lsp_outgoing_calls<CR>", desc = "Outgoing calls" }
      },
      { "<Leader>ld", ":FzfLua lsp_definitions<CR>", desc = "Find definition" },
      {
        "<Leader>le",
        group = "+Diagnostic",
        { "<Leader>lef", ":lua vim.diagnostic.open_float()<CR>", desc = "Error float" },
        { "<Leader>len", ":lua vim.diagnostic.goto_next()<CR>",  desc = "Next error" },
        { "<Leader>lep", ":lua vim.diagnostic.goto_prev()<CR>",  desc = "Previous error" }
      },
      { "<Leader>lf", ":FzfLua lsp_finder<CR>",      desc = "All LSP locations combined view" },
      {
        "<Leader>lh",
        group = "+Helper",
        { "<Leader>lhh", "<cmd>lua vim.lsp.buf.hover()<CR>",          desc = "Lsp hover" },
        { "<Leader>lhs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature help" }
      },
      { "<Leader>li", ":FzfLua lsp_implementations<CR>",  desc = "Find implementation" },
      {
        "<Leader>ln",
        group = "+Nav",
        { "<Leader>lnD", "<cmd>lua vim.lsp.buf.declaration()<CR>",    desc = "Jump to declaration" },
        { "<Leader>lnd", "<cmd>lua vim.lsp.buf.definition()<CR>",     desc = "Jump to definition" },
        { "<Leader>lni", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Jump to implementation" },
      },
      { "<Leader>lr", ":FzfLua lsp_references<CR>",       desc = "Find references" },
      { "<Leader>ls", ":FzfLua lsp_document_symbols<CR>", desc = "Find symbols" },
      { "<Leader>lt", ":FzfLua lsp_typedefs<CR>",         desc = "Find type definition" },
      {
        "<Leader>lw",
        group = "+Workspace",
        { "<Leader>lws", ":FzfLua lsp_live_workspace_symbols<CR>", desc = "Find symbols" },
        { "<Leader>lwx", ":FzfLua diagnostics_workspace<CR>",      desc = "Find diagnostic" }
      },
      { "<Leader>lx", ":FzfLua diagnostics_document<CR>", desc = "Find diagnostic" }
    },
    {
      "<Leader>m",
      group = "+Fzf Misc",
      { "?",          ":FzfLua man_pages<CR>",       desc = "Man pages" },
      { "<Leader>mH", ":FzfLua command_history<CR>", desc = "Commands history" },
      { "<Leader>ma", ":FzfLua autocmds<CR>",        desc = "Autocommands" },
      { "<Leader>mb", ":FzfLua builtin<CR>",         desc = "Fzf-lua builtin commands" },
      { "<Leader>mc", ":FzfLua commands<CR>",        desc = "Nvim commands" },
      { "<Leader>me", ":FzfLua registers<CR>",       desc = "Registers" },
      { "<Leader>mf", ":FzfLua filetypes<CR>",       desc = "Filetypes" },
      { "<Leader>mg", ":FzfLua changes<CR>",         desc = "Changes" },
      { "<Leader>mh", ":FzfLua help_tags<CR>",       desc = "Help tags" },
      { "<Leader>mj", ":FzfLua jumps<CR>",           desc = "Jumps" },
      { "<Leader>mk", ":FzfLua keymaps<CR>",         desc = "Key mapping" },
      { "<Leader>ml", ":FzfLua highlights<CR>",      desc = "Highlight groups" },
      { "<Leader>mm", ":FzfLua marks<CR>",           desc = "Marks" },
      { "<Leader>mn", ":FzfLua menus<CR>",           desc = "Menus" },
      { "<Leader>mo", ":FzfLua colorschemes<CR>",    desc = "Color schemas" },
      { "<Leader>mp", ":FzfLua profiles<CR>",        desc = "Fzf-lua configuration profiles" },
      { "<Leader>mr", ":FzfLua resume<CR>",          desc = "Resume last command/query" },
      { "<Leader>ms", ":FzfLua search_history<CR>",  desc = "Search history" },
      { "<Leader>mt", ":FzfLua tagstack<CR>",        desc = "Tags" },
      { "<Leader>mx", ":FzfLua spell_suggest<CR>",   desc = "Spelling suggestions" },
      { "<Leader>mz", ":FzfLua packadd<CR>",         desc = "Packadd" }
    },
    { "<Leader>y", ":let @+=@%<CR>", desc = "Yank file path" }
  }
)
wk.add(
  {
    { "<C-c>",   ":lua require'oil_manager'.toggle_on_current_folder()<CR>", desc = "Oil current directory" },
    { "<C-f>",   ":lua require'oil_manager'.toggle_on_root_folder()<CR>",    desc = "Oil" },
    { "<S-ESC>", ":noh<CR>",                                                 desc = "No highlights" },
    { "<S-Tab>", ":BufferLineCyclePrev<CR>",                                 desc = "Previous tab" },
    { "<Tab>",   ":BufferLineCycleNext<CR>",                                 desc = "Next tab" },
  }
)
wk.add(
  {
    { "<C-f>",   ":FzfLua grep_visual<CR>", desc = "Grep visual", mode = "v" },
    { "<S-Tab>", "<gv",                     desc = "S-Tab",       mode = "v" },
    { "<Tab>",   ">gv |",                   desc = "Tab",         mode = "v" },
  }
)
wk.add(
  {
    "<Leader>s",
    group = "+Search",
    mode = "v",
    { "<Leader>sv", ":FzfLua grep_visual<CR>", desc = "Grep tags visual", mode = "v" },
  }
)
wk.add({
  { "<S-Tab>", "<gv",   desc = "S-Tab", mode = "x" },
  { "<Tab>",   ">gv |", desc = "Tab",   mode = "x" },
})
