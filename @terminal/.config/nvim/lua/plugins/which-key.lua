-- Shorten timeout to wait for mappings to complete
vim.o.timeout = true
vim.o.timeoutlen = 300


return {

  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local harpoon = require("harpoon")

    require("which-key").add({

      -- Harpoon
      { "<leader>h",  group = "Harpoon" },
      { "<leader>ha", function() harpoon:list():add() end,                         desc = "Add file to harpoon" },
      { "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle harpoon quick menu." },
      { "<leader>hc", function() harpoon.ui:toggle_quick_menu() end,               desc = "Clear harpoon quick menu." },
      { "<leader>hn", function() harpoon:list():next() end,                        desc = "Move to next item in harpoon list." },
      { "<leader>hp", function() harpoon:list():prev() end,                        desc = "Move to previous item in harpoon list." },

    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
