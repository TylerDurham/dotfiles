return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                    -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
        buffers = {
          follow_current_file = { enabled = true }
        },
        filesystem = {
          filtered_items = {
            hide_by_name = { ".DSStore", ".git" },
            hide_dotfiles = false
          }
        }
      })
    end
  }
}
