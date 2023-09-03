local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = '13000',
  executable = {
    command = 'codelldb',
    args = { "--port", "13000" },
  },
}
dap.configurations.cpp = {
  {
    name = "(lldb) Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = {},
    stopAtEntry = false,
    cwd = "${workspaceFolder}",
  }
}
