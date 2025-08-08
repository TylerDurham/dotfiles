-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}
-- ~/.config/nvim/lua/custom/chadrc.lua
M.ui = {
  theme = "catppuccin", -- or whatever you use
  transparency = true,          -- harmless if unsupported
  hl_override = require("highlights").override,
  hl_add      = require("highlights").add,

}
-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
