local dap = require "dap"
local dapui = require "dapui"

dapui.setup()

-- Open/close dap-ui automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Python-specific setup
require("dap-python").setup ".venv/bin/python3" -- Adjust path if needed
