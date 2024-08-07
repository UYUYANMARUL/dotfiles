return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    --   -- import mason
    local mason = require("mason")
    --
    --   -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls
    local mason_null_ls = require("null-ls")

    --   -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "clarinet",
        "rust_analyzer",
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "texlab",
        "vuels",
        "jdtls",
        "zls",
        "omnisharp",
        "solidity_ls_nomicfoundation",
        "elixirls",
      },
      autotag = {
        enable = true,
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
    mason_null_ls.setup({
      -- list of formatters & linters for mason to install
      ensure_installed = {
        "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
        "rustfmt",
        "csharpier",
        "zigfmt",
        "forge_fmt",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true,
    })
  end,
}
