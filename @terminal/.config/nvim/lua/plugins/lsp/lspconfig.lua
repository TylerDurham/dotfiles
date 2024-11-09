return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },

  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")
    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    local on_attach = function(client, buffnr)
      opts.buffer = buffnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- goto declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitionso

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure typescript server
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure gopls server
    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })

    -- configure tailwindcss  server
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure  python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure emmet server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "saas", "sss", "less" }
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,

}
