return {
  {
    "zbirenbaum/copilot-cmp",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.copilot' end,
    dependencies = { 'zbirenbaum/copilot.lua' },
    enabled = function() return os.getenv('NVIM_GH_COPILOT') == 'true' end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = true,
    },
    cmd = { "CopilotChat" },
    enabled = function() return os.getenv('NVIM_GH_COPILOT') == 'true' end,
  },
}
