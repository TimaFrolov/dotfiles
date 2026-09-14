{
  config,
  lib,
  ...
}:
{
  options.tima = {
    laptop = lib.mkEnableOption "laptop mode";
    waybar = {
      backlight = lib.mkOption {
        type = lib.types.bool;
        default = config.tima.laptop;
        description = "Show backlight module in waybar";
      };
      battery = lib.mkOption {
        type = lib.types.bool;
        default = config.tima.laptop;
        description = "Show battery module in waybar";
      };
    };

    unfree = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Allowed unfree packages";
    };
  };

  config.nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) config.tima.unfree;
}
