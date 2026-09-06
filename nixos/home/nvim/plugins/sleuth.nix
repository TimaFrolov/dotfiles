plugins: with plugins; {
  pkg = vim-sleuth;
  event = [
    "BufReadPre"
    "BufNewFile"
  ];
}
