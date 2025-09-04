return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true
      })
    end
  },
  {
    {
      "folke/tokyonight.nvim",
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require("tokyonight").setup({
          transparent = true,
          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
        })
      end,
    },
  },
}
