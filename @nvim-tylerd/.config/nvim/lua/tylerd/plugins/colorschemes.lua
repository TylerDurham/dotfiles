return {
	-- ✅ rose-pine
	-- https://github.com/rose-pine/neovim
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function() end,
	},
	-- ✅ catppuccin
	-- https://github.com/catppuccin/nvim
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
			})
		end,
	},
	{
		-- ✅ tokyonight
		-- https://github.com/folke/tokyonight.nvim
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
