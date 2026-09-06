plugins: with plugins; [
  {
    pkg = nvim-lspconfig;
    event = [
      "BufReadPre"
      "BufNewFile"
    ];
    config = "function() require('tima.configs.lsp') end";
    keys = "require('tima.mappings.lsp')";
  }
  {
    pkg = lazydev-nvim;
    ft = "lua";
    opts.library = [
      {
        path = "\${3rd}/luv/library";
        words = [ "vim%.uv" ];
      }
    ];
  }
  {
    pkg = conform-nvim;
    keys = "require('tima.mappings.conform')";
    event = [
      "BufReadPre"
      "BufNewFile"
    ];
    config = "function() require('tima.configs.conform') end";
  }
]
