return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        config = function()
            require("configs.conform")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
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
