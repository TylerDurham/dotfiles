return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function()
      require("mason").setup({})

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls"
        }
      })

      local lsp_config = require("lspconfig")
      lsp_config.lua_ls.setup({})
      lsp_config.pyright.setup({})

      local mason_tools = require('mason-tool-installer')
      mason_tools.setup({
        ensure_installed = {
          "black",
          "isort",
          "stylua",
          "prettier",
          "shfmt"
        }
      })
    end
  },
}
