return {
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
          }
      end,
  }
