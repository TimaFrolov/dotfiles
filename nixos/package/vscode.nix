{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ vscode ];
  tima.unfree = [ "vscode" ];
}
