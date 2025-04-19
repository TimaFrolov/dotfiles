return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufWinEnter' },
  config = function() require('tima.configs.colorizer') end,
}
