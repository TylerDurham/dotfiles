local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- FIX: Issues with treesitter not opening shell scripts.
        -- sh = { "shfmt" },
        -- zsh = { "shfmt" },
        md = { "markdown", "markdown_inline" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
