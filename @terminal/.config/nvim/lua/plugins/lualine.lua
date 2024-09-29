return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      blue = "#89b4fa",
      green = "#a6e3a1",
      violet = "#FF61EF",
      yellow = "#f9e2af",
      red = "#f38ba8",
      fg = "#c3ccdc",
      bg = "#101010",
      inactive_bg = "#2c3043",
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = "catppuccin"
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
