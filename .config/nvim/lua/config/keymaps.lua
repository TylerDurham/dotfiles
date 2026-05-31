vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape from mode 'INSERT'" })

local function toggle_line_numbers()
	if vim.opt.relativenumber:get() then
		vim.opt.relativenumber = false
	elseif vim.opt.number:get() then
		vim.opt.number = false
	else
		vim.opt.number = true
		vim.opt.relativenumber = true
	end
end

-- utility for current file
map("n", "<leader>ga", "<cmd>! git add %<cr>", { desc = "Git add current file" })
map("n", "<leader>X", "<cmd>! chmod +x %<cr>", { desc = "Make current file executable" })
map("n", "<leader>tn", toggle_line_numbers, { desc = "Toggle Line Numbers" })
