return {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    ft = { "markdown" },
    --dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons

    config = function()
        local keymap = vim.keymap

        keymap.set("n", "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle RenderMarkdown on or off" })
    end,
}
