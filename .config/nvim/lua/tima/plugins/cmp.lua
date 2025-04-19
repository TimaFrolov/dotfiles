return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function() require('tima.configs.cmp') end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
  },
  {
    'L3MON4D3/LuaSnip',
    config = function() require('tima.configs.snippets') end,
    build = 'make install_jsregexp',
    event = 'InsertCharPre',
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
  },
}
