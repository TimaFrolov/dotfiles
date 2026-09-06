plugins: with plugins; {
  pkg = neozoom-lua;
  keys = "require('tima.mappings.zoom')";
  config = "function() require('tima.configs.zoom') end";
}
