{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nasm
    asm-lsp
  ];
}
