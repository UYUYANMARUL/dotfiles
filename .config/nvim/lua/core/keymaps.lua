-- set leader key to space

local keymap = vim.keymap -- for conciseness
---------------------
-- General Keymaps -------------------
--
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
--nnoremap <A-j> :m .+1<CR>==

vim.keymap.set("n", "<A-j>", [[:m .+1<CR>==]], { noremap = true })

vim.keymap.set("n", "<A-k>", [[:m .-2<CR>==]], { noremap = true })

vim.keymap.set("i", "<A-j>", [[<Esc>:m .+1<CR>==gi]], { noremap = true })

vim.keymap.set("i", "<A-k>", [[<Esc>:m .-2<CR>==gi]], { noremap = true })

vim.keymap.set("v", "<A-j>", [[:m '>+1<CR>gv=gv]], { noremap = true })

vim.keymap.set("v", "<A-k>", [[:m '<-2<CR>gv=gv]], { noremap = true })

vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')



local M = {}


M.general = {
  {
    mode = { "i" },
    { "<C-b>", "<ESC>^i", desc = "Beginning of line", nowait = true },
    { "<C-e>", "<End>", desc = "End of line", nowait = true },
    { "<C-g>", "<BS>", desc = "Delete char in insert mode", nowait = true },
    { "<C-h>", "<Left>", desc = "Move left", nowait = true },
    { "<C-l>", "<Right>", desc = "Move right", nowait = true },
    { "<C-j>", "<Down>", desc = "Move down", nowait = true },
    { "<C-k>", "<Up>", desc = "Move up", nowait = true },
  },
  {
    mode = { "n" },
    { "<Esc>", ":noh <CR>", desc = "Clear highlights", nowait = true },
    { "<leader>w", "<cmd> w <CR>", desc = "Save", nowait = true },
    { "<leader>q", "<cmd> q <CR>", desc = "Close", nowait = true },
    { "<C-c>", "<cmd> %y+ <CR>", desc = "Copy whole file", nowait = true },
    { "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, desc = "LSP formatting", nowait = true },
  },
  {
    mode = { "t" },
    { "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), desc = "Escape terminal mode", nowait = true },
  },
  {
    mode = { "v" },
    { "<", "<gv", desc = "Indent line", nowait = true },
    { ">", ">gv", desc = "Indent line", nowait = true },
  },
  {
    mode = { "x" },
    { "p", 'p:let @+=@0<CR>:let @"=@0<CR>', desc = "Dont copy replaced text", nowait = true  },
  },
}

-- M.tmux_navigator = {
 -- {
   -- mode = { "n" },
   -- { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux Navigate Left", nowait = true },
 --   { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux Navigate Down", nowait = true },
 --   { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux Navigate Up", nowait = true },
 --   { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux Navigate Right", nowait = true },
 --   { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Tmux Navigate Previous", nowait = true },
 -- },
 --}

M.harpoon = {
  {
    mode = { "n" },
    { "<leader>h", group = "harpoon" },
    { "<leader>hm", require('harpoon').add_file, desc = "Mark file with harpoon", nowait = true },
    { "<leader>hn", require('harpoon').nav_next, desc = "Go to next harpoon mark", nowait = true },
    { "<leader>hp", require('harpoon').nav_prev, desc = "Go to previous harpoon mark", nowait = true },
    { "<leader>ha", require('harpoon').toggle_quick_menu, desc = "Show harpoon marks", nowait = true },
  },
}

M.oil = {
  {
    mode = { "n" },
    -- { "<leader>j", require('oil').toggle_float, desc = "Toogle Oil File Manager", nowait = true }, -- Uncomment if needed
  },
}

M.buffline = {
  {
    mode = { "n" },
    {

    { "<leader>b", group = "Buffer" },
    { "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous Buffer", nowait = true },
    { "<leader>bn", "<cmd>BufferLineCycleNext<CR>", desc = "Next Buffer", nowait = true },
    { "<leader>bj", "<cmd>BufferLineGoToBuffer<CR>", desc = "Jump to Buffer", nowait = true },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close all to the left", nowait = true },
    { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close all to the right", nowait = true },
    { "<leader>be", "<cmd>BufferLinePickClose<CR>", desc = "No Highlight", nowait = true },
    { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer", nowait = true },
  },
    { "<leader>c", "<cmd>BufferKill<CR>", desc = "Close buffer", nowait = true },
  },
}

M.comment = {
  {
    mode = { "n" },
    {
      "<leader>/",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      desc = "Toggle comment", nowait = true,
    },
  },
  {
    mode = { "v" },
    {
      "<leader>/",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = "Toggle comment", nowait = true,
    },
  },
}

M.lspconfig = {
  {
    mode = { "n" },
    {

    { "<leader>l", group = "lsp" },
    { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "LSP code action", nowait = true,mode={"n","v"} },
    { "<leader>ls", function() vim.lsp.buf.signature_help() end, desc = "LSP signature help", nowait = true },
    { "<leader>lf", function() vim.diagnostic.open_float({ border = "rounded" }) end, desc = "Floating diagnostic", nowait = true },
    { "<leader>ld", function() vim.diagnostic.show() end, desc = "Show diagnostics", nowait = true },
    { "<leader>lq", function() vim.diagnostic.setloclist() end, desc = "Diagnostic setloclist", nowait = true },
    { "<leader>lc", function() vim.lsp.buf.add_workspace_folder() end, desc = "Add workspace folder", nowait = true },
    { "<leader>lr", function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove workspace folder", nowait = true },
    { "<leader>ll", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List workspace folders", nowait = true },


    },
    {
      mode = {"n"},
    { "g", group = "goto" },
    { "gD", function() vim.lsp.buf.declaration() end, desc = "LSP declaration", nowait = true },
    { "gd", function() vim.lsp.buf.definition() end, desc = "LSP definition", nowait = true },
    { "gr", function() vim.lsp.buf.references() end, desc = "LSP references", nowait = true },
    { "gi", function() vim.lsp.buf.implementation() end, desc = "LSP implementation", nowait = true },
    },
    { "K", function() vim.lsp.buf.hover() end, desc = "LSP hover", nowait = true },
    { "<leader>D", function() vim.lsp.buf.type_definition() end, desc = "LSP definition type", nowait = true },
    { "<leader>ra", function() require("nvchad.renamer").open() end, desc = "LSP rename", nowait = true },
    { "[d", function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end, desc = "Goto prev diagnostic", nowait = true },
    { "]d", function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end, desc = "Goto next diagnostic", nowait = true },
  },
}

M.nvimtree = {
  {
    mode = { "n" },
    { "<leader>e", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree", nowait = true },
  },
}

M.telescope = {
  {
    mode = { "n" },
    {
      "<leader>f",
      group = "Find"
    },
    {
      "<leader>ff",
      "<cmd> Telescope find_files <CR>",
      desc = "Find files",
      nowait = true
    },
    {
      "<leader>fa",
      "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
      desc = "Find all",
      nowait = true
    },
    {
      "<leader>fw",
      "<cmd> Telescope live_grep <CR>",
      desc = "Live grep",
      nowait = true
    },
    {
      "<leader>fb",
      "<cmd> Telescope buffers <CR>",
      desc = "Find buffers",
      nowait = true
    },
    {
      "<leader>fh",
      "<cmd> Telescope help_tags <CR>",
      desc = "Help page",
      nowait = true
    },
    {
      "<leader>fo",
      "<cmd> Telescope oldfiles <CR>",
      desc = "Find oldfiles",
      nowait = true
    },
    {
      "<leader>fz",
      "<cmd> Telescope current_buffer_fuzzy_find <CR>",
      desc = "Find in current buffer",
      nowait = true
    },
    {
      "<leader>g",
      group = "Telescope Git"
    },
    {
      "<leader>gc",
      "<cmd> Telescope git_commits <CR>",
      desc = "Git commits",
      nowait = true
    },
    {
      "<leader>gt",
      "<cmd> Telescope git_status <CR>",
      desc = "Git status",
      nowait = true
    },
    {
      "<leader>pt",
      "<cmd> Telescope terms <CR>",
      desc = "Pick hidden term",
      nowait = true
    },
    {
      "<leader>ma",
      "<cmd> Telescope marks <CR>",
      desc = "telescope bookmarks",
      nowait = true
    },
  },
}

M.fold = {
  {
    mode = { "n" },
    { "zo", "<cmd>foldopen<CR>", desc = "Open Folded Code", nowait = true },
    { "zf", "<cmd>foldclose<CR>", desc = "Fold Code", nowait = true },
    { "za", "za", desc = "Toggle Fold", nowait = true },
    { "zO", "zR", desc = "Open All Folded Code", nowait = true },
    { "zF", "zM", desc = "Fold Code", nowait = true },
  },
}

M.whichkey = {
  {
    mode = { "n" },
    {
      "<leader>k", group = "Whichkey"

    },
    {
      "<leader>kK",
      function()
        vim.cmd("WhichKey")
      end,
      desc = "Which-key all keymaps", nowait = true,
    },
    {
      "<leader>kk",
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      desc = "Which-key query lookup", nowait = true,
    },
  },
}

M.gitsigns = {
  {
    mode = { "n" },
    {
      "]c",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      desc = "Jump to next hunk", nowait = true,
    },
    {
      "[c",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      desc = "Jump to prev hunk", nowait = true ,
    },
    {
      "<leader>rh",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset hunk", nowait = true,
    },
    {
      "<leader>ph",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview hunk", nowait = true,
    },
    {
      "<leader>gb",
      function()
        package.loaded.gitsigns.blame_line()
      end,
      desc = "Blame line", nowait = true,
    },
    {
      "<leader>td",
      function()
        require("gitsigns").toggle_deleted()
      end,
      desc = "Toggle deleted", nowait = true,
    },
  },
}


M.dap = {
  {
    mode = { "n" },
    { "<leader>db", "<cmd> DapToggleBreakpoint <CR>", desc = "Toggle Breakpoint", nowait = true },
    {
      "<leader>dus",
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      desc = "Open debugging sidebar", nowait = true,
    },
  },
}

M.crates = {
  {
    mode = { "n" },
    {
      "<leader>rcu",
      function()
        require("crates").upgrade_all_crates()
      end,
      desc = "Update crates", nowait = true,
    },
  },
}

M.floatterminal = {
  {
    mode = { "n" },
    { "<C-\\>", "<cmd> FloatermToggle <CR>", desc = "Open Floaterminal", nowait = true },
    { "<C-z>", "<cmd> FloatermToggle <CR>", desc = "Open Floaterminal (alt)", nowait = true },
  },
  {
    mode = { "t" },
    { "<C-\\>", "<cmd> FloatermToggle <CR>", desc = "Open Floaterminal", nowait = true },
    { "<C-z>", "<cmd> FloatermToggle <CR>", desc = "Open Floaterminal (alt)", nowait = true },
  },
}


local K = {}
for _, value in pairs(M) do
    table.insert(K, value)
end
return K
