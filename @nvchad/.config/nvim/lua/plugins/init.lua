return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre", "BufNewFile" }, -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local mason = require "mason"
            local mason_lsp_config = require "mason-lspconfig"

            mason.setup {

                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            }

            mason_lsp_config.setup {
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "gopls",
                    "html",
                    "cssls",
                    "emmet_ls",
                },
            }

            local mason_tool_installer = require "mason-tool-installer"
            mason_tool_installer.setup {
                ensure_installed = {
                    "prettier", -- prettier formatter
                    "stylua", -- lua formatter
                    "isort", -- python formatter
                    "black", -- python formatter
                    "ruff",
                    "lua-language-server",
                    "pylint", -- python linter
                    "eslint_d", -- js linter
                    "goimports",
                },
                run_on_start = true,
                start_delay = 3000,
            }
        end,
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
