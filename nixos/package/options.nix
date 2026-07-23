{ config, lib, ... }:
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
  };
}
