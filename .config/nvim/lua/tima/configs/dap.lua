local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = '13000',
  executable = {
    command = 'codelldb',
    args = { "--port", "13000" },
  },
}

dap.adapters.coreclr = {
  type = 'server',
  port = '13001',
  executable = {
    command = 'netcoredbg',
    args = { '--interpreter=vscode', '--server=13001' }
  }
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

dap.configurations.cs = {
  {
    name = "(netcoredbg) Launch",
    type = "coreclr",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll:', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
    args = {},
    stopAtEntry = false,
    cwd = "${workspaceFolder}",
  },
}
