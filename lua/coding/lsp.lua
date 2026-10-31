-- Format on save and inlay hints are wired per-buffer from the LspAttach
-- handler in `lua/config/autocmds.lua`, which only enables each feature for
-- clients that actually advertise the matching capability.
-- Servers for other machines go in lua/config/local.lua (see the README).

-- cmp_nvim_lsp adds what the completion menu supports, such as snippets
local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities())
capabilities.general.positionEncodings = { "utf-16" }

-- Diagnostics of the cursor line drawn as lines below it
vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

local servers = {
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
    before_init = function(_, config)
      -- a single file outside any project has no root
      if not config.root_dir then
        return
      end
      local venv = config.root_dir .. "/.venv/bin/python"
      if vim.fn.executable(venv) == 1 then
        config.settings.python.pythonPath = venv
      end
    end,
    settings = {
      -- ruff sorts the imports
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- a project asks for strict in its pyrightconfig.json
          typeCheckingMode = "standard",
        }
      }
    }
  },
  ruff = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    on_attach = function(client)
      -- pyright answers the hover with the types and the docs
      client.server_capabilities.hoverProvider = false
    end,
  },
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go" },
    root_markers = { "go.mod", ".git" },
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
  },
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  },
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "avsc" },
    root_markers = { ".git" },
  },
  -- lazydev.nvim gives it the Neovim API and the plugins in the config
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".git" },
  },
  bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh" },
    root_markers = { ".git" },
  },
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_markers = { ".git" },
  },
  marksman = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    root_markers = { ".git" },
  },
  cmake = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt", ".git" },
  },
  -- installed by mason; the licence key is read from ~/intelephense/licence.txt
  intelephense = {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { ".git", "composer.json" },
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      intelephense = {
        stubs = {
          "bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo", "filter", "gd",
          "gettext", "hash", "iconv", "imap", "intl", "json", "libxml", "mbstring",
          "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql",
          "Phar", "readline", "regex", "session", "SimpleXML", "sockets", "sodium",
          "standard", "superglobals", "tokenizer", "xml", "xdebug", "xmlreader",
          "xmlwriter", "yaml", "zip", "zlib", "wordpress-stubs", "woocommerce-stubs",
          "acf-pro-stubs", "wordpress-globals", "wp-cli-stubs", "genesis-stubs",
          "polylang-stubs"
        },
        environment = {
          includePaths = { "/home/blacksheep/.composer/vendor/" }
        },
        files = {
          maxSize = 5000000,
        },
      },
    },
  },
  rust_analyzer = {
    cmd = { "rust-analyzer" }, -- assicurati che il binario sia nel PATH
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        check = {
          command = "clippy",
        },
        diagnostics = {
          enable = true,
          disabled = { "unresolved-proc-macro" },
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  local cfg = vim.tbl_extend("force", {
    capabilities = capabilities,
  }, opts)

  -- Registra/estendi la config corretta: primo argomento = stringa nome
  vim.lsp.config(name, cfg)

  -- Abilita l'auto-start (si attiverà quando apri file con i giusti filetypes/root)
  vim.lsp.enable(name)
end

require 'coding.formatters'.init()
