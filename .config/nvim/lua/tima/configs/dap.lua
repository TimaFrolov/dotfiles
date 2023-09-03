local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = '13000',
  executable = {
    command = 'codelldb',
    args = { "--port", "13000" },
  },
}

dap.adapters.cppdbg = {
  type = 'executable',
  command = 'OpenDebugAD7',
}

dap.adapters.coreclr = {
  type = 'server',
  port = '13001',
  executable = {
    command = 'netcoredbg',
    args = { '--interpreter=vscode', '--server=13001' }
  }
}

---@type fun(string, string): string
local function getExecutable(prompt, initPath)
  if not prompt then
    prompt = 'Path to executable:'
  end
  if not initPath then
    initPath = vim.fn.getcwd() .. '/'
  end
  return vim.fn.input(prompt, initPath, 'file')
end

---@type fun(string): table
local function getArgs(prompt)
  if not prompt then
    prompt = 'Program arguments:'
  end
  return vim.split(vim.fn.input(prompt), ' ')
end

--- @type fun(string, string): string
local function getCwd(prompt, initPath)
  if not prompt then
    prompt = 'Working directory:'
  end
  if not initPath then
    initPath = vim.fn.getcwd()
  end
  return vim.fn.input(prompt, initPath, 'dir')
end

dap.configurations.cpp = {
  {
    name = "(lldb) Launch",
    type = "codelldb",
    request = "launch",
    stopAtEntry = false,
    program = getExecutable,
    args = getArgs,
    cwd = getCwd,
  }
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.configurations.cs = {
  {
    name = "(netcoredbg) Launch",
    type = "coreclr",
    request = "launch",
    stopAtEntry = false,
    program = function() getExecutable('Path to dll:', vim.fn.getcwd() .. '/bin/Debug') end,
    args = getArgs,
    cwd = getCwd,
  },
}
