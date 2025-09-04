vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode with jj" })

vim.keymap.set("n", "<leader>qq", ":qa!<cr>", { desc = "@: Close Neovim by (q)uick (q)uitting." })

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "@: Open Telescope and (f)ind (f)iles." })
vim.keymap.set("n", "<leader>fa", function() builtin.find_files({ hidden = true, ignore = true }) end,
  { desc = "@: Open Telescope and (f)ind (a)ll files, including hidden." })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "@: Open Telescope and (l)ive (g)rep to find files." })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "@: Open Telescope and (f)ind (b)uffers." })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "@: Open Telescope and (f)ind (h)elp tags." })

-- Neo-tree keymaps
vim.keymap.set("n", "<leader>ee", ":Neotree toggle filesystem<cr>", { desc = "@: Toggle(e) N(e)o tree file explorer." })
vim.keymap.set("n", "<leader>ec", ":Neotree reveal left filesystem<cr>",
  { desc = "@: Reveal N(e)o tree revealing (c)urrent file. " })

-- lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "@: vim.lsp.buf.hover" })
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, { desc = "" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "@: " })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "@: vim.lsp.buf.code_action" })

-- Harpoon
vim.keymap.set("n", "<leader>ha", function()
  require("harpoon.mark").add_file()
end, { desc = "@: Use (h)arpoon to (a)dd a mark." }
)
vim.keymap.set("n", "<leader>hl", function ()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "@: Use (h)arpoon to (l)ist marks." }
)
vim.keymap.set("n", "<leader>hp", function ()
  require("harpoon.ui").nav_prev()
end, { desc = "@: Use (h)arpoon to navigate (p)revious mark." }
)
vim.keymap.set("n", "<leader>hn", function ()
  require("harpoon.ui").nav_next()
end, { desc = "@: Use (h)arpoon to navigate (n)next mark." }
)
