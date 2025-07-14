return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Show all files, including dotfiles
        hide_dotfiles = false, -- Explicitly allow dotfiles
        hide_gitignored = true, -- Optional: keep gitignored files hidden
        show_hidden_count = true,
        hide_by_name = {
          -- Add specific files/folders to hide, e.g., ".git", ".DS_Store"
        },
        never_show = {
          -- Add files to always hide, e.g., ".git"
          ".git",
          ".DS_Store",
        },
      },
    },
  },
}
