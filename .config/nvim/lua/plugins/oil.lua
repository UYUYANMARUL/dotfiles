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
["-"] =  "",
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
    preview_split = "above",
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

local window_buffers = {}

vim.keymap.set('n', '<leader>j', function()
  local win_id = vim.api.nvim_get_current_win()
  local buf_name = vim.api.nvim_buf_get_name(0)

  if buf_name:match("^oil://") then
    -- If oil.nvim is open, switch back to the saved buffer for the window
    if window_buffers[win_id] and vim.api.nvim_buf_is_valid(window_buffers[win_id]) then
      vim.api.nvim_set_current_buf(window_buffers[win_id])
    else
      print("No previous buffer to restore")
    end
    window_buffers[win_id] = nil  -- Clear the buffer reference
  else
    -- Save the current buffer and open oil.nvim
    window_buffers[win_id] = vim.api.nvim_get_current_buf()
    require("oil").open()  -- Open oil.nvim
  end
end, { noremap = true, silent = true })


-- Autocmd to switch back to the previous buffer when oil.nvim is closed
vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "oil://*",
  callback = function()
    local win_id = vim.api.nvim_get_current_win()
    if window_buffers[win_id] and vim.api.nvim_buf_is_valid(window_buffers[win_id]) then
      window_buffers[win_id] = nil
    else
    end
  end,
})

-- Open oil in split
vim.keymap.set("n", "<leader>op", function()
	local oil = require("oil")
	local util = require("oil.util")

	oil.open()
	util.run_after_load(0, function()
		oil.select({ preview = true })
	end)
end, { desc = "Open oil with preview" })


    end,
  },
}
