-- bootstrap lazy.nvim, LazyVim and your plugins
vim.keymap.set("n", "<c-z>", "<nop>")
vim.g.mapleader = " "

local vim = vim

local buff = vim.api.nvim_get_current_buf()
local path = vim.api.nvim_buf_get_name(buff)

-- elixir formatter code

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.ex", "*.exs" },
  callback = function()
    buff = vim.api.nvim_get_current_buf()
    path = vim.api.nvim_buf_get_name(buff)
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ex", "*.exs" },
  callback = function()
    os.execute("mix format " .. path)
    vim.cmd([[e!]])
  end,
})

require("lazyy")
require("core")
require("whichkey")

local kmap = vim.keymap.set

-- F5 processes the document once, and refreshes the view
kmap({ "n", "v", "i" }, "<F5>", function()
  require("knap").process_once()
end)

-- F6 closes the viewer application, and allows settings to be reset
kmap({ "n", "v", "i" }, "<F6>", function()
  require("knap").close_viewer()
end)

-- F7 toggles the auto-processing on and off
kmap({ "n", "v", "i" }, "<F7>", function()
  require("knap").toggle_autopreviewing()
end)

-- F8 invokes a SyncTeX forward search, or similar, where appropriate
kmap({ "n", "v", "i" }, "<F8>", function()
  require("knap").forward_jump()
end)
