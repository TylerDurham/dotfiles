return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Tree toggle. Show/hide the file explorer." }) -- toggle file explorer
    keymap.set("n", "<leader>tF", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Tree Find. Toggle the file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "Tree collapse. Collapse the file explorer." }) -- collapse file explorer
    keymap.set("n", "<leader>tf", "<cmd>NvimTreeFocus<CR>", { desc = "Tree focus. Return focus to the file explorer." }) -- toggle file explorer on current file
    keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Tree refresh. Refresh the file explorer." }) -- refresh file explorer
  end
}
