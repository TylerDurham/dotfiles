return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  after = "catppuccin",
  config = function()
    local bufferline = require("bufferline")


    bufferline.setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
        -- highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
        --- count is an integer representing total count of errors
        --- level is a string "error" | "warning"
        --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
        --- this should return a string
        --- Don't get too fancy as this function will be executed a lot
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end
      }
    })
  end
}
