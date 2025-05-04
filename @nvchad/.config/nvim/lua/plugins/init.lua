return {
    {
        "nvim-treesitter/nvim-treesitter",
        --- Load treesitter when we read a file or create open a file.
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },
    {
        "stevearc/conform.nvim",
        --- Loads conform.nvim during these event(s).
        event = "BufWritePre",
        config = function()
            --- Calls the config to perform the rest of setup.
            require("configs.conform")
        end,
    },
    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            -- Modify existing options
            opts.defaults.hidden = true

            -- Modify picker-specific settings
            opts.pickers = opts.pickers or {}
            opts.pickers.find_files = vim.tbl_deep_extend("force", opts.pickers.find_files or {}, {
                hidden = true,
            })

            return opts
        end,
    },
}
