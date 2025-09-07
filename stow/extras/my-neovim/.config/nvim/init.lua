require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocommands")

-- Customize diagnostic signs
local signs = { Error = "✘ ", Warn = "▲ ", Hint = "⚑ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = true,  -- inline messages
  signs = true,         -- use gutter signs
  underline = true,     -- underline problem code
  update_in_insert = false,
  severity_sort = true,
})
