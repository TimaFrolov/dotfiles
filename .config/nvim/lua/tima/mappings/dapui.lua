return {
  { "<leader>do", function() require('dapui').toggle({ reset = true }) end, desc = "[D]ap [O]pen UI" },
  { "<leader>dk", function() require('dapui').eval() end,                   desc = "[D]ap show current symbol" },
}
