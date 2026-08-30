{
  inputs,
  ...
}:
{
  imports = [
    ../package/hyprland.nix
    ../package/waybar.nix
    ../../package/catppuccin.nix
    inputs.catppuccin.homeModules.catppuccin
  ];
}
