return { "voldikss/vim-floaterm",
 config= function()
    vim.cmd("FloatermNew --height=0.6 --width=0.8 --wintype=float --name=floaterm1 --position=center")
    
    vim.cmd("FloatermToggle")

    vim.api.nvim_input("<Esc>")
  end
}
