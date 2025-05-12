local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "ruff", "isort" },
        go = { "goimports" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },
    formatters = {
        black = {
            prepend_args = { "--fast" },
            timeout_ms = 5000,
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 4000,
        lsp_fallback = true,
    },
}

return options
