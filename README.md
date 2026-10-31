# NVIM dot files

TODO:  
[ ] Fix which-key nil errors on startup
[ ] Fix tangerine and lazy setup  
[X] Fix warnings  
[ ] Fix treesitter plugin (it install all the parser every time  
[X] Fix swift formatters, warnings and errors  
[ ] Refactor for layers  
[ ] global options module  
[X] migrate to Lazy
[X] refactor bindings to be semantically aligned with vim's feature ("b" for "buffers" "w" for "window"[...])  
[X] fix comment (TODO) highlighting. It is highlighted for a moment then it turns gray  
[X] fix dap breakpoint icons  
[ ] improve dap supported  
[X] enable Fennel configuration
[X] extract from original repo  
[ ] improve Golang support (fix also the check-health warnings

## Machine-specific additions

`lua/config/local.lua` extends the configuration on one machine only and is
ignored by git. It returns two optional fields:

- `plugins`: lazy.nvim specs, merged with `lua/plugins`;
- `setup`: a function run after the main configuration, for LSP servers,
  debug adapters and anything else.

Format on save, inlay hints and the completion capabilities reach these
servers too, through the same `LspAttach` handler as the core ones.

### Example: TypeScript/JavaScript, Elm and Dexter

Copy it to `lua/config/local.lua` on the machine that needs it. The mason
packages install on the first start; Dexter is not in mason and must be on
the `PATH`.

```lua
-- lua/config/local.lua: additions for this machine only, ignored by git
local js_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

return {
  plugins = {},

  setup = function()
    -- Tools from mason, installed when missing
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs({
        "typescript-language-server",
        "eslint-lsp",
        "js-debug-adapter",
        "elm-language-server",
        "elm-format",
      }) do
        local pkg = registry.get_package(name)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end)

    local capabilities = vim.tbl_deep_extend("force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities())

    -- TypeScript/JavaScript: ts_ls for types and navigation, ESLint for lint
    -- and formatting, so ts_ls does not format
    local inlay_hints = {
      includeInlayParameterNameHints = "all",
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }
    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = js_filetypes,
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
      capabilities = capabilities,
      settings = {
        typescript = { inlayHints = inlay_hints },
        javascript = { inlayHints = inlay_hints },
      },
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })

    -- Starts only in projects with an ESLint configuration
    vim.lsp.config("eslint", {
      cmd = { "vscode-eslint-language-server", "--stdio" },
      filetypes = js_filetypes,
      root_markers = {
        "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts",
        ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml",
      },
      capabilities = capabilities,
      settings = {
        validate = "on",
        format = true,
        quiet = false,
        run = "onType",
        onIgnoredFiles = "off",
        nodePath = "",
        rulesCustomizations = {},
        workingDirectory = { mode = "location" },
        problems = { shortenToSingleLine = false },
        codeActionOnSave = { enable = false, mode = "all" },
        codeAction = {
          disableRuleComment = { enable = true, location = "separateLine" },
          showDocumentation = { enable = true },
        },
      },
      -- the server wants its workspace folder among the settings
      before_init = function(_, config)
        if config.root_dir then
          config.settings.workspaceFolder = {
            uri = vim.uri_from_fname(config.root_dir),
            name = vim.fn.fnamemodify(config.root_dir, ":t"),
          }
        end
      end,
    })

    -- Elm; elm-language-server formats through elm-format
    vim.lsp.config("elmls", {
      cmd = { "elm-language-server" },
      filetypes = { "elm" },
      root_markers = { "elm.json" },
      capabilities = capabilities,
    })

    -- Dexter, Elixir
    vim.lsp.config("dexter", {
      cmd = { "dexter", "lsp" },
      filetypes = { "elixir", "eelixir", "heex" },
      root_markers = { ".dexter/dexter.db", ".dexter.db", "mix.exs", ".git" },
      capabilities = capabilities,
      init_options = {
        followDelegates = true, -- jump through defdelegate to the target function
        -- stdlibPath = "",      -- override Elixir stdlib path (auto-detected)
        -- debug = false,        -- verbose logging to stderr (view with :LspLog)
      },
    })

    vim.lsp.enable({ "ts_ls", "eslint", "elmls", "dexter" })

    -- Node and browser debugging through js-debug-adapter
    local dap = require("dap")
    for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
      dap.adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = { command = "js-debug-adapter", args = { "${port}" } },
      }
    end
    for _, ft in ipairs(js_filetypes) do
      dap.configurations[ft] = {
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
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Start Chrome with \"localhost\"",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
      }
    end
  end,
}
```
