return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Default parsers. Use :TSInstall parser_name for others as needed.
      -- ensure_installed = {"lua", "javascript"},
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
