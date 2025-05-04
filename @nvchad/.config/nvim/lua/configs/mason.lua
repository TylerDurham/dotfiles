return {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            -- FIX: Issues with treesitter not opening shell scripts.
            -- "bash-language-server",
            "lua-language-server",
            "pyright",
            "stylelua",
            -- etc.
        },
    },
}
