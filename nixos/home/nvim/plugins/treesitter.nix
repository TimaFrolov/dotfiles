plugins: with plugins; {
  pkg = nvim-treesitter;
  keys = "require('tima.mappings.treesitter')";
  event = [
    "BufReadPre"
    "BufNewFile"
  ];
  build = ":TSUpdate";
  config = "function() require('tima.configs.treesitter') end";
  dependencies = [
    nvim-treesitter-context
    nvim-treesitter-textobjects
  ];
}
