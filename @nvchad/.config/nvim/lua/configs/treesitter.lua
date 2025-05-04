local options = {
    ensure_installed = {

        -- FIX: Issues with treesitter not opening shell scripts.
        -- "bash",
        -- FIX: This is causing an error on adding a new parser.
        -- "zsh",
        "fish",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        -- "shfmt",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
