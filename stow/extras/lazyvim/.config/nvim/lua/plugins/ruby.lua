-- lua/plugins/ruby.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          -- default config, used for .rb files
        },
        solargraph = {
          enabled = false, -- disable globally
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      -- Setup ruby-lsp (default for Ruby)
      lspconfig.ruby_lsp.setup(opts.servers.ruby_lsp)

      -- Setup solargraph only for erb
      lspconfig.solargraph.setup(vim.tbl_deep_extend("force", opts.servers.solargraph, {
        filetypes = { "eruby" },
      }))
    end,
  },
}
