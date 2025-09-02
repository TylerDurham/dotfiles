return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "none", -- disable default keymaps
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
  },
}
