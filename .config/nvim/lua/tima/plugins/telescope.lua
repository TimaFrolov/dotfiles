return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim'
  },
  config = function() require 'tima.configs.telescope' end,
  keys = require 'tima.mappings.telescope',
}
