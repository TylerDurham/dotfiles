return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre", "BufNewFile" }, -- uncomment for format on save
        opts = require "configs.conform",
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "lua_ls",
                "stylua",
                "pyright",
                "black",
                "ruff",
                "isort",
                "gopls",
                "goimports",
            },
        },
    },
    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- BUG: https://github.com/LazyVim/LazyVim/issues/524
            opts.ignore_install = { "help" }

            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, {
                    "python",
                    "lua",
                    "markdown",
                    "bash",
                    "go",
                })
            end
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            config = function()
                require("dap-go").setup()
            end,
        },
    },
}
