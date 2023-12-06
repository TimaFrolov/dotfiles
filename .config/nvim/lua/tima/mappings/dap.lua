local dapui = require('dapui')
local dap = require('dap')
vim.keymap.set("n", "<leader>do", function() dapui.toggle({ reset = true }) end, { desc = "[D]ap [O]pen UI" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ap [C]ontinue" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "[D]ap step to [N]ext line" })
vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "[D]ap [S]tep [I]nto" })
vim.keymap.set("n", "<leader>dso", dap.step_out, { desc = "[D]ap [S]tep [O]ut" })
vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "[D]ap [p]ause" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ap set [B]reakpoint" })
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = "[D]ap set conditional [B]reakpoint" })
vim.keymap.set("n", "<leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
  { desc = "[D]ap set [L]ogpoint" })
vim.keymap.set("n", "<leader>dk", dapui.eval, { desc = "[D]ap show current symbol" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[D]ap [T]erminate" })
vim.keymap.set("n", "<leader>dee", function() dap.set_exception_breakpoints("default") end,
  { desc = "[D]ap stop on [E]xceptions [E]nable" })
vim.keymap.set("n", "<leader>ded", function() dap.set_exception_breakpoints({}) end,
  { desc = "[D]ap stop on [E]xceptions [D]isable" })
