return {
    --- TODO: Need to test this
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
    lazy = false,
    opts = {
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",        
            "--glob=!.git/",  
          },
    },
  },
 }
