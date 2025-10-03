vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "lua vim.lsp.buf.format()",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
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
    cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { "json" },
    root_markers = { ".git" },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".git" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
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
  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
  },
  cmake = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt", ".git" },
  },
  tilt_ls = {
    cmd = { "tilt_ls" },
    -- in alternativa, se hai solo tilt installato:
    -- cmd = { "tilt", "ls", "serve", "--lsp" },
    filetypes = { "tiltfile" },
    root_markers = { "Tiltfile", ".git" },
  },
  intelephense = {
    cmd = { "intelephense", "--stdio" }, -- assicurati che il binario sia nel PATH
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
        checkOnSave = {
          command = "clippy",
        },
        diagnostics = {
          enable = true,
          disabled = { "unresolved-proc-macro" },
        },
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        inlayHints = {
          bindingModeHints = true,
          chainingHints = true,
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          parameterHints = true,
          typeHints = true,
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  local cfg = vim.tbl_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
  }, opts)

  -- Registra/estendi la config corretta: primo argomento = stringa nome
  vim.lsp.config(name, cfg)

  -- Abilita l'auto-start (si attiverà quando apri file con i giusti filetypes/root)
  vim.lsp.enable(name)
end

require('go').setup({
  lsp_inlay_hints = {
    enable = false
  }
})


require 'coding.custom_formatters'.init()
