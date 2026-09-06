plugins: with plugins; [
  {
    pkg = nvim-cmp;
    event = [
      "BufReadPre"
      "BufNewFile"
    ];
    config = "function() require('tima.configs.cmp') end";
    dependencies = [
      cmp-nvim-lsp
      luasnip
    ];
  }
  {
    pkg = luasnip;
    config = "function() require('tima.configs.snippets') end";
    build = "make install_jsregexp";
    event = "InsertCharPre";
    dependencies = [ cmp_luasnip ];
  }
]
