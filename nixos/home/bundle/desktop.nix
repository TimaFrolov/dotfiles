{
  config,
  ...
}:
{
  imports = [
    ../package/hyprland.nix
    ../package/waybar.nix
  ];

  programs.thunderbird = {
    enable = true;
    profiles.${config.home.username}.isDefault = true;
  };

  catppuccin.thunderbird.profile = config.home.username;
}
