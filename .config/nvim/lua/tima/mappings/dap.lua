return {
  { "<leader>dc",  function() require('dap').continue() end,                                                    desc = "[D]ap [C]ontinue" },
  { "<leader>dn",  function() require('dap').step_over() end,                                                   desc = "[D]ap step to [N]ext line" },
  { "<leader>dsi", function() require('dap').step_into() end,                                                   desc = "[D]ap [S]tep [I]nto" },
  { "<leader>dso", function() require('dap').step_out() end,                                                    desc = "[D]ap [S]tep [O]ut" },
  { "<leader>dp",  function() require('dap').pause() end,                                                       desc = "[D]ap [p]ause" },
  { "<leader>db",  function() require('dap').toggle_breakpoint() end,                                           desc = "[D]ap set [B]reakpoint" },
  { "<leader>dB",  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,        desc = "[D]ap set conditional [B]reakpoint" },
  { "<leader>dl",  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "[D]ap set [L]ogpoint" },
  { "<leader>dt",  function() require('dap').terminate() end,                                                   desc = "[D]ap [T]erminate" },
  { "<leader>dee", function() require('dap').set_exception_breakpoints("default") end,                          desc = "[D]ap stop on [E]xceptions [E]nable" },
  { "<leader>ded", function() require('dap').set_exception_breakpoints({}) end,                                 desc = "[D]ap stop on [E]xceptions [D]isable" },
}
