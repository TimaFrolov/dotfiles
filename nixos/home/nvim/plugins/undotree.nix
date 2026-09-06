plugins: with plugins; {
  pkg = undotree;
  keys = "require('tima.mappings.undotree')";
  event = [
    "BufReadPre"
    "BufNewFile"
  ];
}
