require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- TODO: Need to move to plugin file? Not sure...
map("n", "ft", "<cmd> TodoTelescope <CR>", { desc = "Telescope find todo's" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
