require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- TODO: Need to move to plugin file? Not sure...
map("n", "ft", "<cmd> TodoTelescope <CR>", { desc = "Telescope find todo's" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--- NOTE: Requires shfmt. See configs.conform for configuration.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh", "*.zsh" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
