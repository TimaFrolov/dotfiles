return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  },
  config = function() require('tima.configs.telescope') end,
  keys = require('tima.mappings.telescope'),
}
