-- =========================================================================
-- ___ ____ ___  ____    ____ ____ _  _ _  _ ____ _  _ ___ ____  _  _ _  _ _ _  _
--  |  |  | |  \ |  | __ |    |  | |\/| |\/| |___ |\ |  |  [__   |\ | |  | | |\/|
--  |  |__| |__/ |__|    |___ |__| |  | |  | |___ | \|  |  ___] .| \|  \/  | |  |
--
-- =========================================================================
-- https://github.com/folke/todo-comments.nvim
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    setup = function()
        require("todo-comments").setup {}
    end,
}
