{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ vscode ];
  nixpkgs.config.allowUnfreePackages = [ "vscode" ];
}
