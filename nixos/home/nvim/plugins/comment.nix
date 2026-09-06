plugins: with plugins; {
  pkg = comment-nvim;
  event = [
    "BufReadPre"
    "BufNewFile"
  ];
  config = "function() require('tima.configs.comment') end";
}
