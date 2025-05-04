require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

local dap = require "dap"
local dapui = require "dapui"

map("n", "<leader>db", function()
    dap.set_breakpoint()
end, { desc = "Set [B]reakpoint." })

map("n", "<F5>", function()
    dap.continue()
end, { desc = "Start/continue debugger." })

map("n", "<F10>", function()
    dap.step_into()
end, { desc = "Step Info." })

-- local M = {}
--
-- M.dap = {
--     n = {
--         ["<F5>"] = {
--             function()
--                 dap.continue()
--             end,
--             "Start/continue debugger",
--         },
--         ["<F10>"] = {
--             function()
--                 dap.step_over()
--             end,
--             "Step over",
--         },
--         ["<F11>"] = {
--             function()
--                 dap.step_into()
--             end,
--             "Step into",
--         },
--         ["<F12>"] = {
--             function()
--                 dap.step_out()
--             end,
--             "Step out",
--         },
--         ["<Leader>b"] = {
--             function()
--                 dap.toggle_breakpoint()
--             end,
--             "Toggle breakpoint",
--         },
--         ["<Leader>B"] = {
--             function()
--                 dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
--             end,
--             "Conditional breakpoint",
--         },
--         ["<Leader>dr"] = {
--             function()
--                 dap.repl.open()
--             end,
--             "Open DAP REPL",
--         },
--         ["<Leader>dl"] = {
--             function()
--                 dap.run_last()
--             end,
--             "Run last debug session",
--         },
--     },
-- }
--
-- return M
-- -- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
