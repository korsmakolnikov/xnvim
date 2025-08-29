vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "lua vim.lsp.buf.format()",
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'clangd', 'jsonls', 'elmls', 'lua_ls', 'bashls', 'yamlls', 'marksman' }
for _, lsp in pairs(servers) do
  require 'lspconfig'[lsp].setup {
    -- on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  }
end

require 'lspconfig'.intelephense.setup({
  settings = {
    intelephense = {
      stubs = {
        "bcmath",
        "bz2",
        "Core",
        "curl",
        "date",
        "dom",
        "fileinfo",
        "filter",
        "gd",
        "gettext",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "libxml",
        "mbstring",
        "mcrypt",
        "mysql",
        "mysqli",
        "password",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "Phar",
        "readline",
        "regex",
        "session",
        "SimpleXML",
        "sockets",
        "sodium",
        "standard",
        "superglobals",
        "tokenizer",
        "xml",
        "xdebug",
        "xmlreader",
        "xmlwriter",
        "yaml",
        "zip",
        "zlib",
        "wordpress-stubs",
        "woocommerce-stubs",
        "acf-pro-stubs",
        "wordpress-globals",
        "wp-cli-stubs",
        "genesis-stubs",
        "polylang-stubs"
      },
      environment = {
        includePaths = { '/home/blacksheep/.composer/vendor/' }
      },
      files = {
        maxSize = 5000000,
      },
    },
  },
  capabilities = capabilities,
  -- on_attach = on_attach
});

require 'lspconfig'.gopls.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
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
    },
  },
}

require('go').setup({})


require 'lspconfig'.ts_ls.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  root_dir = require 'lspconfig'.util.root_pattern("package.json"),
  single_file_support = false
}

require 'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        extraArgs = { "--profile", "rust-analyzer" },
        extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
      checkOnSave = {
        command = "clippy"
      },
    }
  }
}

require 'lspconfig'.cmake.setup {}

require 'lspconfig.configs'.fennel_language_server = {
  default_config = {
    cmd = { 'fennel-language-server' },
    filetypes = { 'fennel' },
    single_file_support = true,
    -- source code resides in directory `fnl/`
    root_dir = require 'lspconfig'.util.root_pattern("fnl"),
    settings = {
      fennel = {
        workspace = {
          -- If you are using hotpot.nvim or aniseed,
          -- make the server aware of neovim runtime files.
          library = vim.api.nvim_list_runtime_paths(),
          checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
        },
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
}

require 'coding.custom_formatters'.init()

require 'lspconfig'.tilt_ls.setup {}
