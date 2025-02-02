return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand "%"
        path = path:gsub("oil://", "")

        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-c>"] = {function ()
            vim.cmd("bd!")
          end},
          ["<C-r>"] = "actions.refresh",
          ["<C-h>"] = "actions.parent",
          ["<C-l>"] = "actions.select",
          ["<C-j>"] =  "",
          ["<C-k>"] = "",
          ["<M-h>"] = "actions.select_split",
        },
        delete_to_trash = true,
        cleanup_delay_ms = 2000,
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
  float = {
    -- Padding around the floating window
    padding = 0,
    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    max_width = 0,
    max_height = 0,
    border = "none",
    win_options = {
      winblend = 0,
    },
    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
    get_win_title = nil,
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
            return vim.tbl_contains(folder_skip, name)
          end,
        },
      }

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    end,
  },
}
