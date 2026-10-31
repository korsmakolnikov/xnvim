-- Every key binding of the configuration lives here, so collisions show up in
-- one place. `setup` registers the global bindings through which-key; the
-- other functions hold the bindings owned by a plugin or by a buffer.
local M = {}

function M.setup()
  local gs = require('gitsigns')
  local wk = require("which-key")
  local ts = require("telescope.builtin")

  local function debug_test()
    local ft = vim.bo.filetype
    if ft == "go" then
      require("dap-go").debug_test()
    elseif ft == "python" then
      require("dap-python").test_method()
    else
      vim.notify("No test debugging for " .. ft, vim.log.levels.WARN)
    end
  end

  wk.add({
    {
      "<C-c>",
      group = "+Cursor",
      { "<C-c>s", ts.spell_suggest,              desc = "Spell suggestions" },
      {
        "<C-c>c",
        function()
          ts.git_bcommits_range({
            from = vim.fn.getpos("'<")[2],
            to = vim.fn.getpos(
              "'>")[2]
          })
        end,
        desc = "Commits in range",
        mode = "v"
      },
      { "<C-c>v", ":FzfLua grep_visual<CR>",     desc = "Grep selected",         mode = "v" },
      { "<C-c>W", ":FzfLua grep_cWORD<CR>",      desc = "Grep WORD under cursor" },
      { "<C-c>w", ":FzfLua grep_cword<CR>",      desc = "Grep word under cursor" },
      { "<C-c>t", ":FzfLua tags_grep_cWORD<CR>", desc = "Grep tags for WORD under cursor" },
      { "<C-c>T", ":FzfLua tags_grep_cword<CR>", desc = "Grep tags for word under cursor" },
      {
        "<C-c>h",
        group = "+Coding helpers",
        { "<C-c>hh", "<cmd>lua vim.lsp.buf.hover()<CR>",          desc = "Lsp hover", },
        { "<C-c>hH", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature help" },
        {
          "<C-c>hi",
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
          end,
          desc = "Toggle inlay hints"
        },
      },

      {
        "<C-c>c",
        group = "+Coding Nav",
        { "<C-c>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>",    desc = "Jump to declaration" },
        { "<C-c>cd", "<cmd>lua vim.lsp.buf.definition()<CR>",     desc = "Jump to definition" },
        { "<C-c>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Jump to implementation" },
        { "<C-c>cn", function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = "Next error" },
        { "<C-c>cp", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous error" },
      },
    },

    {
      group = "+Tabs",
      { "<S-Tab>", "<gv",   desc = "S-Tab", mode = "x" },
      { "<Tab>",   ">gv |", desc = "Tab",   mode = "x" },
    },

    {
      "<Leader>f",
      group = "+File",
      { "<Leader>f<Space>", ts.find_files,                                              desc = "Search for files", },
      { "<Leader>fg",       ts.git_files,                                               desc = "Search for git files", },
      { "<Leader>fh",       ts.oldfiles,                                                desc = "History", },
      { "<Leader>fy",       ":let @+=@%<CR>",                                           desc = "Yank file path" },
      { "<Leader>fC",       ":lua require'explorer'.toggle_on_current_folder()<CR>", desc = "Oil current directory" },
      { "<Leader>fc",       ":lua require'explorer'.toggle_on_root_folder()<CR>",    desc = "Oil" },
    },

    {
      "<Leader>c",
      group = "+Coding",
      { "<Leader>cq", ts.quickfix,                                                                                 desc = "Quickfixes", },
      { "<Leader>cQ", ts.quickfixhistory,                                                                          desc = "Quickfixes history", },
      { "<Leader>cr", ts.lsp_references,                                                                           desc = "References", },
      { "<Leader>cI", ts.lsp_incoming_calls,                                                                       desc = "Incoming calls", },
      { "<Leader>cO", ts.lsp_outgoing_calls,                                                                       desc = "Outgoing calls", },
      { "<Leader>ce", ":lua require('telescope.builtin').diagnostics({wrap_results=true, line_width='full'})<cr>", desc = "Diagnostic", },
      { "<Leader>ci", ts.lsp_implementations,                                                                      desc = "Implementations", },
      { "<Leader>cd", ts.lsp_definitions,                                                                          desc = "Definition", },
      { "<Leader>ct", ts.treesitter,                                                                               desc = "Treesitter", },
      { "<Leader>cT", ts.lsp_type_definitions,                                                                     desc = "Type definition", },
      { "<Leader>cD", ":FzfLua lsp_declarations<CR>",                                                              desc = "Find declaration" },
      { "<Leader>cR", "<cmd>lua vim.lsp.buf.rename()<CR>",                                                         desc = "Rename symbol" },
      { "<Leader>cE", ":FzfLua diagnostics_document<CR>",                                                          desc = "Find diagnostic" },
      { "<Leader>cf", ":FzfLua lsp_finder<CR>",                                                                    desc = "All LSP locations combined view" },
      { "<Leader>ca", ":FzfLua lsp_code_actions<CR>",                                                              desc = "Find code actions" },
    },

    {
      "<Leader>C",
      group = "+Configuration",
      { "<Leader>C<Space>", ":e $MYVIMRC<CR>", desc = "Open init.lua", },
    },

    {
      "<Leader>b",
      group = "+Buffer",
      { "<Leader>b<Space>", ts.buffers,                                        desc = "Buffers list" },
      { "<Leader>bc",       ts.git_bcommits,                                   desc = "Buffer commits" },
      { "<Leader>bd",       ":bd<CR>",                                         desc = "Delete", },
      { "<Leader>bl",       ":FzfLua blines<CR>",                              desc = "Find better lines" },
      { "<Leader>bL",       ":FzfLua lines<CR>",                               desc = "Find lines" },
      { "<Leader>bt",       ":FzfLua tabs<CR>",                                desc = "Find tabs" },
      { "<Leader>bF",       function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, desc = "Format" },
      { "<Leader>bT",       ts.current_buffer_tags,                            desc = "Fuzzy find tags", },
      { "<Leader>bs",       ts.lsp_document_symbols,                           desc = "Symbols", },
      { "<Leader>bf",       ts.current_buffer_fuzzy_find,                      desc = "Fuzzy finder" },
      { "<Leader>bG",       ":FzfLua lgrep_curbuf<CR>",                        desc = "LGrep current buffer" },
      { "<Leader>bg",       ":FzfLua grep_curbuf<CR>",                         desc = "Grep current buffer" },
      {
        group = "+Buffer Nav",
        { "<S-Tab>", ":bp<CR>", desc = "Previous buffer" },
        { "<Tab>",   ":bn<CR>", desc = "Next buffer" },
        -- a terminal with the kitty keyboard protocol tells <C-i> from <Tab>,
        -- but nvim folds it back into <Tab> unless <C-i> has its own map
        { "<C-i>",   "<C-i>",   desc = "Jump forward" },
      },
    },

    {
      "<Leader>w",
      group = "+Workspace",
      { "<Leader>we", ":FzfLua diagnostics_workspace<CR>", desc = "Find diagnostic" },
      { "<Leader>ws", ts.lsp_workspace_symbols,            desc = "Workspace symbols", },
      { "<Leader>wS", ts.lsp_dynamic_workspace_symbols,    desc = "Dynamic workspace symbols", },
      { "<Leader>wT", ":FzfLua tags_grep<CR>",             desc = "Grep project tags" },
      { "<Leader>wt", ":FzfLua tags<CR>",                  desc = "Find tags project" },
    },

    {
      "<C-w>",
      group = "+Window"
    },

    {
      "<Leader>t",
      group = "+Tab",
      { "<Leader>tN", ":tabnew<CR>",       desc = "New tab" },
      { "<Leader>tc", ":tabclose<CR>",     desc = "Close the current tab" },
      { "<Leader>te", ":tabedit<CR>",      desc = "Open empty file in a new tab" },
      { "<Leader>tn", ":tabnext<CR>",      desc = "Next tab" },
      { "<Leader>tp", ":tabprevious<CR>",  desc = "Previous tab" },
      { "<Leader>tr", ":tabmove +1<CR>",   desc = "Move to the right" },
      { "<Leader>tl", ":tabmove -1<CR>",   desc = "Move to the left" },
      { "<Leader>tF", ":tabfirst<CR>",     desc = "Switch to first tab" },
      { "<Leader>tL", ":tablast<CR>",      desc = "Switch to last tab" },
      { "<Leader>tR", ":Tabby rename_tab ", desc = "Rename tab" },
      { "<Leader>tO", ":tabonly<CR>",      desc = "Close other tabs" },
    },

    {
      "<Leader>v",
      group = "+Vim",
      { "<Leader>vc", ts.commands,        desc = "Commands", },
      { "<Leader>vC", ts.command_history, desc = "Commands history", },
      { "<Leader>vH", ts.man_pages,       desc = "Man pages", },
      { "<Leader>vm", ts.marks,           desc = "Marks", },
      { "<Leader>vs", ts.colorschemes,    desc = "Color schemes", },
      { "<Leader>vl", ts.loclist,         desc = "Locations list" },
      { "<Leader>vj", ts.jumplist,        desc = "Jumps list" },
      { "<Leader>vo", ts.vim_options,     desc = "Options" },
      { "<Leader>vr", ts.registers,       desc = "Registers" },
      { "<Leader>va", ts.autocommands,    desc = "Autocommands" },
      { "<Leader>vk", ts.keymaps,         desc = "Keymaps" },
      { "<Leader>vf", ts.filetypes,       desc = "Filetypes" },
      { "<Leader>vh", ts.highlights,      desc = "Highlights" },
      { "<Leader>vb", ts.builtin,         desc = "Telescope builtin" },
      { "<Leader>vR", ts.reloader,        desc = "Reloader lua modules" },
      { "<Leader>vS", ts.symbols,         desc = "UTF-8 Symbols" },
      { "<S-ESC>",    ":noh<CR>",         desc = "No highlights" },
    },

    {
      "<Leader>d",
      group = "+Debug",
      { "<Leader>dB", function() require("dap").toggle_breakpoint() end,                                 desc = "Toggle breakpoint" },
      { "<Leader>dI", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,         desc = "Conditional breakpoint" },
      { "<Leader>dL", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: ")) end,     desc = "Log point" },
      { "<Leader>dC", function() require("dap").continue() end,                                          desc = "Start / continue" },
      { "<Leader>dn", function() require("dap").step_over() end,                                         desc = "Step over" },
      { "<Leader>di", function() require("dap").step_into() end,                                         desc = "Step into" },
      { "<Leader>dO", function() require("dap").step_out() end,                                          desc = "Step out" },
      { "<Leader>dl", function() require("dap").run_last() end,                                          desc = "Run last" },
      { "<Leader>dT", function() require("dap").terminate() end,                                         desc = "Terminate" },
      { "<Leader>dt", debug_test,                                                                        desc = "Debug test under cursor" },
      { "<Leader>dU", function() require("dapui").toggle() end,                                          desc = "Toggle debug UI" },
      { "<Leader>dh", function() require("dap.ui.widgets").hover() end,                                  desc = "Inspect value under cursor" },
      { "<Leader>dR", ":lua require'dap'.repl.open()<CR>",                                               desc = "REPL" },
      { "<Leader>db", ":FzfLua dap_breakpoints<CR>",                                                     desc = "List breakpoints" },
      { "<Leader>dc", ":FzfLua dap_commands<CR>",                                                        desc = "DAP commands" },
      { "<Leader>df", ":FzfLua dap_frames<CR>",                                                          desc = "Active session jump to frame" },
      { "<Leader>do", ":FzfLua dap_configurations<CR>",                                                  desc = "DAP configurations" },
      { "<Leader>dv", ":FzfLua dap_variables<CR>",                                                       desc = "Active session variables" },
      { "<M-k>",      function() require("dapui").eval() end,                                            desc = "Evaluate expression", mode = { "n", "v" } },
      { "<F5>",       function() require("dap").continue() end,                                          desc = "Debug: start / continue" },
      { "<F10>",      function() require("dap").step_over() end,                                         desc = "Debug: step over" },
      { "<F11>",      function() require("dap").step_into() end,                                         desc = "Debug: step into" },
      { "<F12>",      function() require("dap").step_out() end,                                          desc = "Debug: step out" },
    },

    {
      "<Leader>g",
      group = "+Git",
      { "<Leader>gs", ts.git_status,          desc = "Status" },
      { "<Leader>gb", ts.git_branches,        desc = "Branches" },
      { "<Leader>gc", ts.git_commits,         desc = "Commits project" },
      { "<Leader>gS", ts.git_stash,           desc = "Stash" },
      { "<Leader>gt", ":FzfLua git_tags<CR>", desc = "Tags" },
      {
        "<Leader>gy",
        "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        desc = "Gitlinker"
      },
      {
        "<Leader>gy",
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        desc = "Gitlinker",
        mode = "v"
      },
    },

    {
      "<Leader>G",
      group = "+Gitsigns",
      {
        "<Leader>Gh",
        group = "+Hunk",
        { "<Leader>Ghs", gs.stage_hunk,                                                       desc = "Gitsigns stage hunk" },
        { "<Leader>Ghr", gs.reset_hunk,                                                       desc = "Gitsigns reset hunk", },
        { "<Leader>Ghr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Gitsigns reset hunk",     mode = 'v' },
        { "<Leader>Ghs", function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Gitsigns stage hunk",     mode = 'v' },
        { "<Leader>Ghu", gs.undo_stage_hunk,                                                  desc = "Gitsigns undo stage hunk" },
        { "<Leader>Ghp", gs.preview_hunk,                                                     desc = "Gitsigns preview hunk" },
      },
      {
        "<Leader>Gb",
        group = "+Buffer",
        { "<Leader>Gbs", gs.stage_buffer, desc = "Gitsigns stage buffer" },
        { "<Leader>Gbr", gs.reset_buffer, desc = "Gitsigns reset buffer" },
      },
      { "<Leader>Gd", gs.diffthis,                                  desc = "Gitsigns git diff" },
      { "<Leader>GD", function() gs.diffthis('~') end,              desc = "Gitsigns git diff" },
      { "<Leader>GE", gs.toggle_deleted,                            desc = "Gitsigns toggle deleted" },
      { "<Leader>Gl", function() gs.blame_line { full = true } end, desc = "Gitsigns line blame" },
    },

    {
      "<Leader>s",
      group = "+Global Search",
      { "<Leader>sh", ts.search_history,              desc = "Search history" },
      { "<Leader>sr", ts.resume,                      desc = "Resume last picker" },
      { "<Leader>sH", ts.pickers,                     desc = "List Previous pickers" },
      { "<Leader>sb", ":FzfLua live_grep_glob<CR>",   desc = "Live grep glob" },
      { "<Leader>sg", ts.grep_string,                 desc = "Live grep project" },
      { "<Leader>sl", ts.live_grep,                   desc = "Live grep project" },
      { "<Leader>sn", ":FzfLua live_grep_native<CR>", desc = "Live grep native" },
      { "<Leader>sR", ":FzfLua live_grep_resume<CR>", desc = "Live grep resume" },
      { "<Leader>st", ":FzfLua tags_live_grep<CR>",   desc = "Live grep" },
    },

    { "<Leader>S", ":mksession!<CR>", desc = "Replace session file" },

    {
      "<Leader>T",
      group = "+Tags",
      { "<Leader>Th", ts.help_tags, desc = "Help tags" },
    },

    {
      "<Leader>m",
      group = "+Fzf Misc",
      { "<Leader>m?", ":FzfLua man_pages<CR>",       desc = "Man pages" },
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

    {
      "<Leader>e",
      group = "+Trouble",
      { "<Leader>e<Space>", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0 win.position=top<CR>", desc = "Trouble diagnostics buffer" },
      { "<Leader>ew",       "<cmd>Trouble diagnostics toggle focus=false win.position=top<CR>",              desc = "Trouble diagnostics workspace" },
      { "<Leader>em",       "<cmd>Trouble<CR>",                                                              desc = "Trouble menu" },
    },

    {
      group = "+Snippets",
      mode = { "i", "s" },
      { "<C-L>",   function() require("luasnip").jump(1) end,   desc = "Next snippet node" },
      { "<C-J>",   function() require("luasnip").jump(-1) end,  desc = "Previous snippet node" },
      {
        "<C-E>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        desc = "Next snippet choice"
      },
      { "<C-S-E>", function() require("luasnip.loaders").edit_snippet_files() end, desc = "Edit snippet files" },
    },
  })

  if vim.g.neovide then
    vim.keymap.set({ "i", "c" }, "<C-S-v>", "<C-R>+", { desc = "Paste from the system clipboard" })
  end
end

-- Insert-mode bindings of the completion menu, for cmp.setup.
function M.cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  return cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- falls back to the snippet choice binding when the menu is closed
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            select = true,
          })
        end
      else
        fallback()
      end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  })
end

-- Command-line bindings of the completion menu.
function M.cmp_cmdline()
  return require("cmp").mapping.preset.cmdline()
end

-- Slide navigation of the presenting mode, local to the slides buffer.
function M.presentation(buf)
  vim.keymap.set('n', '<Right>', ':bn<CR>', { buffer = buf, silent = true, desc = "Next slide" })
  vim.keymap.set('n', '<Left>', ':bp<CR>', { buffer = buf, silent = true, desc = "Previous slide" })
end

return M
