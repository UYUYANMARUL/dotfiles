local cmp = require("cmp")

local plugins = {
  { "christoomey/vim-tmux-navigator" },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require("plugins.lsp.configs.rust-tool-config")
    end,
    config = function(opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function() end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   lazy = false,
  --   config = function(_, opts)
  --     require("nvim-dap-virtual-text").setup()
  --   end,
  -- },
}

return plugins
