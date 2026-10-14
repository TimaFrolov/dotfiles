{
  config,
  lib,
  ...
}:
{
  options.tima = {
    dev = {
      enable = lib.mkEnableOption "dev packages";
      nvim = lib.mkOption {
        type = lib.types.bool;
        default = config.tima.dev.enable;
      };
    };

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
