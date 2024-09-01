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

-- use jk to exit insert mode
local M = {}

M.general = {
  plugins = true,
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },
    ["<C-g>"] = { "<BS>", "Delete char in insert mode" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },

    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },

    -- save
    ["<leader>w"] = { "<cmd> w <CR>", "Save" },

    ["<leader>q"] = { "<cmd> q <CR>", "Close" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "LSP formatting",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    -- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
  },

  x = {
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.tmux_navigator = {
  n = {

    ["<C-h>"] = { "<cmd><C-U>TmuxNavigateLeft<cr>" },
    ["<C-j>"] = { "<cmd><C-U>TmuxNavigateDown<cr>" },
    ["<C-k>"] = { "<cmd><C-U>TmuxNavigateUp<cr>" },
    ["<C-l>"] = { "<cmd><C-U>TmuxNavigateRight<cr>" },
    ["<C-\\>"] = { "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}

M.harpoon = {
  n = {

    ["<leader>hm"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark file with harpoon" },

    ["<leader>hn"] = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Go to next harpoon mark" },

    ["<leader>hp"] = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Go to previous harpoon mark" },

    ["<leader>ha"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show harpoon marks" },
  },
}

M.buffline = {

  n = {
    ["<leader>bb"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous" },

    ["<leader>bn"] = { "<cmd>BufferLineCycleNext<CR>", "Next" },

    ["<leader>bj"] = { "<cmd>BufferLineGoToBuffer<CR>", "jump" },

    ["<leader>bh"] = { "<cmd>BufferLineCloseLeft<CR>", "Close all to the left" },

    ["<leader>bl"] = { "<cmd>BufferLineCloseRight<CR>", "Close all to the right" },

    ["<leader>be"] = { "<cmd>BufferLinePickClose<CR>", "No Highlight" },

    ["<leader>bp"] = { "<cmd>BufferLinePick<CR>", "Pick Buffer" },

    ["<leader>c"] = { "<cmd>BufferKill<CR>", "Close buffer" },
  },
}

M.comment = {

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {

    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    -- ["<leader>f"] = {
    --   function()
    --     vim.diagnostic.open_float({ border = "rounded" })
    --   end,
    --   "Floating diagnostic",
    -- },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
      end,
      "Goto next",
    },

    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "Diagnostic setloclist",
    -- },

    ["<leader>lc"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>lr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>ll"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    -- ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.telescope = {

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    -- ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.fold = {
  n = {
    ["zo"] = { "<cmd>foldopen<CR>", "Open Folded Code" },
    ["zf"] = { "<cmd>foldclose<CR>", "Fold Code" },
    ["za"] = { "za", "Toogle Fold" },
    ["zO"] = { "zR", "Open All Folded Code" },
    ["zF"] = { "zM", "Fold Code" },
  },
}

M.nvterm = {

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle("float")
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle("float")
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      "Toggle vertical term",
    },

    -- new
    -- ["<leader>h"] = {
    --   function()
    --     require("nvterm.terminal").new "horizontal"
    --   end,
    --   "New horizontal term",
    -- },
    --
    -- ["<leader>v"] = {
    --   function()
    --     require("nvterm.terminal").new "vertical"
    --   end,
    --   "New vertical term",
    -- },
  },
}

M.whichkey = {

  n = {
    ["<leader>kK"] = {
      function()
        vim.cmd("WhichKey")
      end,
      "Which-key all keymaps",
    },
    ["<leader>kk"] = {
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.gitsigns = {

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.dap = {
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<leader>dus"] = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "update crates",
    },
  },
}

M.floatterminal = {
  n = {

    ["<C-\\>"] = { "<cmd> FloatermToggle <CR>", "Open Floaterminal" },

    ["<C-z>"] = { "<cmd> FloatermToggle <CR>", "Open Floaterminal" },
  },
  t = {

    ["<C-\\>"] = { "<cmd> FloatermToggle <CR>", "Open Floaterminal" },

    ["<C-z>"] = { "<cmd> FloatermToggle <CR>", "Open Floaterminal" },
  },
}

return M
