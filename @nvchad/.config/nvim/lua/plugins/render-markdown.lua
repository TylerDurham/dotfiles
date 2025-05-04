--[[
____ ____ _  _ ___  ____ ____    _  _ ____ ____ _  _ ___  ____ _ _ _ _  _ 
|__/ |___ |\ | |  \ |___ |__/ __ |\/| |__| |__/ |_/  |  \ |  | | | | |\ | 
|  \ |___ | \| |__/ |___ |  \    |  | |  | |  \ | \_ |__/ |__| |_|_| | \| 

NOTE: More info at https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
--]]
return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
    --dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    event = "BufReadPre",
    config = function()
        require("render-markdown").setup({
            file_types = { "markdown", "quarto" },
            render_modes = { "n", "c", "t" },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle RenderMarkdown on or off" })
    end,
}
