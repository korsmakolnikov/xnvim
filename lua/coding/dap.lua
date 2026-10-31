-- DAP debug
local dap = require('dap')
local dapui = require('dapui')
local mason = vim.fn.stdpath("data") .. "/mason/packages"

-- C, C++ and Rust through codelldb, installed by mason
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = mason .. '/codelldb/extension/adapter/codelldb',
    args = { '--port', '${port}' },
  },
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = function()
      return vim.split(vim.fn.input('Arguments: '), ' ', { trimempty = true })
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
  {
    -- Attaching to a process not started by the debugger needs
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    name = 'Attach to process',
    type = 'codelldb',
    request = 'attach',
    pid = require('dap.utils').pick_process,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Go through delve
require('dap-go').setup()

-- Python through debugpy, installed by mason; nvim-dap-python runs the
-- program with the project's interpreter, from $VIRTUAL_ENV or ./.venv
require('dap-python').setup(mason .. '/debugpy/venv/bin/python')

-- Variable values next to the code while the session is stopped, cut short:
-- the whole value is in the UI scopes or under <Leader>dh
require('nvim-dap-virtual-text').setup({
  virt_text_pos = 'eol',
  commented = true,
  display_callback = function(variable)
    local value = variable.value:gsub("%s+", " ")
    if #value > 60 then
      value = value:sub(1, 57) .. "..."
    end
    return variable.name .. ' = ' .. value
  end,
})

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
vim.fn.sign_define('DapLogPoint', { text = '◉', texthl = 'DiagnosticInfo' })
vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DiagnosticHint' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticOk', linehl = 'Visual' })

-- Javascript DAP adapter
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug",                                                     -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local js_based_languages = { "typescript", "javascript", "typescriptreact" }

for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }
  }
end
