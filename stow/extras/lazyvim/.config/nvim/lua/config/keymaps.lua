-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<esc><cr>", { desc = "CUSTOM: My insert mode escape keybind." })
vim.keymap.set("n", "<leader>ee", ":Neotree focus<cr>")
