return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  -- "neovim/nvim-lspconfig",
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "lua_ls",
        "emmet_ls",
        "html",
        "gopls",
        "cssls",
        "tailwindcss",
        "pyright"
      },
      -- automatically install configured servers
      automatic_installation = true, -- Not the same as ensure_installed
    })
  end
}
