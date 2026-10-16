{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    cargo
    clippy
    rustfmt
    rustc
    rust-analyzer
  ];
}
