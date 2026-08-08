{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    perf
    flamegraph
  ];
}
