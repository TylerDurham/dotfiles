return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
		config = function(_, opts)
			require("barbar").setup(opts)

			-- Barbar (tabs)
			vim.keymap.set({ "n", "v" }, "<tab>", ":BufferNext<cr>", { desc = "Barber: Next buffer" })
			vim.keymap.set({ "n", "v" }, "<s-tab>", ":BufferPrevious<cr>", { desc = "Barbar: Previous buffer" })

			vim.keymap.set({ "n", "v" }, "<leader>qc", ":BufferClose<cr>", { desc = "Barbar: Close current buffer" })
		end,
	},
}
