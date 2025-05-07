-- https://github.com/akinsho/bufferline.nvim
vim.opt.termguicolors = true
-- using lazy.nvim

return {
    'akinsho/bufferline.nvim', 
    version = "*", 
    event = "VeryLazy",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
        })
    end
}
