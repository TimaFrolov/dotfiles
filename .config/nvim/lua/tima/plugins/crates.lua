return {
  'saecki/crates.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = "toml",
  config = function() require('crates').setup() end,
}
