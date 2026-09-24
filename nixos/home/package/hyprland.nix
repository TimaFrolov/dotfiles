{
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];
    extraConfig = ''require("tima")'';
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({action = \"enable\"})'";
        lock_cmd = "${lib.getExe pkgs.swaylock} -f -c 000000";
      };
      listener = [
        {
          on-timeout = "${lib.getExe pkgs.swaylock} -f -c 000000";
          timeout = 600;
        }
        {
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({action = \"enable\"})'";
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({action = \"disable\"})'";
          timeout = 600;
        }
        {
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({action = \"enable\"})'";
          on-timeout = "pidof swaylock && hyprctl dispatch 'hl.dsp.dpms({action = \"disable\"})'";
          timeout = 30;
        }
        {
          on-timeout = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 1";
          timeout = 1200;
        }
      ];
    };
  };

  home.packages = with pkgs; [
    swaylock
  ];

  home.file.".config/hypr/tima" = {
    source = ../../../.config/hypr/tima;
    recursive = true;
  };
}
