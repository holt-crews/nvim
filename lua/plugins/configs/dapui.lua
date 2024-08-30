local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- NOTE: these are actually a part of nvim-dap, but because it's part of the ui, I'm leaving it in dapui.lua
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = '', numhl = 'red' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'yellow', linehl = '', numhl = 'yellow' })
