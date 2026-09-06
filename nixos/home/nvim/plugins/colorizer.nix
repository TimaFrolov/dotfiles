plugins: with plugins; {
  pkg = nvim-colorizer-lua;
  event = [ "BufWinEnter" ];
  config = "function() require('tima.configs.colorizer') end";
}
