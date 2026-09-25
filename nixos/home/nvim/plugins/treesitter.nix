{ plugins, pkgs, ... }: with plugins;
rec {
  pkg = nvim-treesitter;
  keys = "require('tima.mappings.treesitter')";
  event = [
    "BufReadPre"
    "BufNewFile"
  ];
  config = ''
    function()
      vim.opt.runtimepath:append("${
        pkgs.symlinkJoin {
          name = "nvim-treesitter-grammars";
          paths = pkg.dependencies;
        }
      }")
      require('tima.configs.treesitter')
    end'';
  dependencies = [
    nvim-treesitter-context
    nvim-treesitter-textobjects
  ];
}
