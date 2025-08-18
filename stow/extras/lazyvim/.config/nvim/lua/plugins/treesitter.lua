return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "lua", "javascript", "markdown", "markdown_inline" },
      auto_install = true,
    })
  end,
}
