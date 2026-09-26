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
        (
          let
            state-file = ''"$XDG_RUNTIME_DIR/pw-idle"'';
          in
          {
            on-resume =
              (pkgs.writeShellScript "pw-resume" ''
                wpctl set-mute @DEFAULT_AUDIO_SINK@ $(cat ${state-file})
                rm ${state-file}
              '').outPath;
            on-timeout =
              (pkgs.writeShellScript "pw-idle" ''
                wpctl get-vulume @DEFAULT_AUDIO_SINK@ | grep MUTED | wc -l > ${state-file}
                wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
              '').outPath;
            timeout = 1200;
          }
        )
      ];
    };
  };

  home.packages = with pkgs; [
    swaylock
  ];

  xdg.configFile."hypr/tima" = {
    source = ../../../.config/hypr/tima;
    recursive = true;
  };
}
