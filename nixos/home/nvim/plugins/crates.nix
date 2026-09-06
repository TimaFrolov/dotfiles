plugins: with plugins; {
  pkg = crates-nvim;
  dependencies = [ plenary-nvim ];
  event = [ "BufRead Cargo.toml" ];
  config = "function() require('crates').setup({}) end";
}
