-- ~/.config/nvim/lua/custom/highlights.lua
local M = {}

M.override = {
  Normal     = { bg = "none" },
  NormalNC   = { bg = "none" },
  SignColumn = { bg = "none" },
  LineNr     = { bg = "none" },
  CursorLineNr = { bg = "none" },
  VertSplit  = { bg = "none" },
  WinSeparator = { bg = "none" },

  -- NvimTree / file explorers
  NvimTreeNormal   = { bg = "none" },
  NvimTreeNormalNC = { bg = "none" },
  NvimTreeEndOfBuffer = { bg = "none" },

  -- Telescope main panes
  TelescopeNormal        = { bg = "none" },
  TelescopeResultsNormal = { bg = "none" },
  TelescopePreviewNormal = { bg = "none" },
}

M.add = {}

-- Transparency hook — runs after theme loads
local function make_transparent()
  for _, g in ipairs(vim.tbl_keys(M.override)) do
    pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
  end
end

vim.api.nvim_create_autocmd({ "User", "ColorScheme" }, {
  pattern = { "VeryLazy", "*" },
  callback = make_transparent,
})

return M
