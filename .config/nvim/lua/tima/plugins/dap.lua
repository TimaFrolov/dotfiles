return {
  'mfussenegger/nvim-dap',
  keys = require('tima.mappings.dap'),
  config = function() require('tima.configs.dap') end,
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      keys = require('tima.mappings.dapui'),
      config = function() require('dapui').setup() end,
      dependencies = { 'nvim-neotest/nvim-nio' }
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function() require('nvim-dap-virtual-text').setup({}) end,
    },
  }
}
