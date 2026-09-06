plugins: with plugins; [
  {
    pkg = noice-nvim;
    keys = "require('tima.mappings.noice')";
    dependencies = [
      nui-nvim
      nvim-notify
      nvim-treesitter
    ];
    event = [ "VeryLazy" ];
    config = "function() require('tima.configs.noice') end";
  }
  {
    pkg = nvim-notify;
    config = "function() require('tima.configs.nvim-notify') end";
  }
  {
    pkg = lualine-nvim;
    lazy = false;
    dependencies = [ nvim-web-devicons ];
    config = "function() require('tima.configs.lualine') end";
  }
]
