plugins: with plugins; [
  {
    pkg = vim-fugitive;
    cmd = "Git";
    dependencies = [ telescope-nvim ];
    keys = "require('tima.mappings.fugitive')";
  }
  {
    pkg = gitsigns-nvim;
    event = [
      "BufReadPre"
      "BufNewFile"
    ];
    keys = "require('tima.mappings.gitsigns')";
    config = "function() require('tima.configs.gitsigns') end";
  }
  {
    pkg = lazygit-nvim;
    dependencies = [ plenary-nvim ];
    keys = "require('tima.mappings.lazygit')";
  }
]
