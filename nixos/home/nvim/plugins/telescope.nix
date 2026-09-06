plugins: with plugins; {
  pkg = telescope-nvim;
  dependencies = [
    plenary-nvim
    nvim-treesitter
    {
      pkg = telescope-fzf-native-nvim;
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release";
    }
    telescope-ui-select-nvim
    telescope-file-browser-nvim
  ];
  config = "function() require('tima.configs.telescope') end";
  keys = "require('tima.mappings.telescope')";
}
