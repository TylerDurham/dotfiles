vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "YankHighlight",
      timeout = 200,
    })

  end,
})

vim.cmd([[highlight YankHighlight guibg=#ffffaf ctermbg=229]])
