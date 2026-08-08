{
  lib,
  osConfig,
  ...
}:
let
  backlight = osConfig.tima.waybar.backlight;
  battery = osConfig.tima.waybar.battery;
in
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        position = "bottom";

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "hyprland/language"
          "custom/audio_idle_inhibitor"
          "idle_inhibitor"
          "custom/notifications"
          "custom/keyboard"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
        ]
        ++ lib.optional backlight "backlight"
        ++ lib.optional battery "battery";

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{name} {icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        "hyprland/submap" = {
          format = " {}";
          default-submap = "default";
          tooltip = false;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "{:%a, %d %b %Y  %H:%M:%S}";
          on-click = "gnome-calendar";
          interval = 1;
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
          interval = 1;
        };

        memory = {
          format = "{used:.2f}GiB   {swapUsed:.2f}GiB";
          interval = 1;
        };

        temperature = {
          thermal-zone = 1;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          interval = 1;
        };

        "backlight" = lib.mkIf backlight {
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "battery" = lib.mkIf battery {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          interval = 1;
        };

        network = {
          interface = "??p*";
          format-wifi = "{essid} ({signaldBm}dBm) {icon}";
          format-ethernet = "{ipaddr}/{cidr} 󰛳";
          tooltip-format = "{ifname} via {gwaddr} 󰛳";
          format-linked = "{ifname} (No IP) 󰛳";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = "󰸈  {format_source}";
          format-muted = "󰸈 {format_source}";
          format-source = "{volume}% 󰍬";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "pavucontrol";
        };

        "custom/keyboard" = {
          format = "󰌌";
          on-click = "command kill -s RTMIN $(pgrep wvkbd-mobintl)";
        };

        "custom/notifications" = {
          exec = "if [ $(dunstctl is-paused) = false ]; then echo \"\"; else echo \"\"; fi";
          format = "{}";
          interval = 1;
          on-click = "dunstctl set-paused toggle;";
        };

        "custom/audio_idle_inhibitor" = {
          format = "{icon}";
          exec = "sway-audio-idle-inhibit --dry-print-both-waybar";
          exec-if = "which sway-audio-idle-inhibit";
          return-type = "json";
          format-icons = {
            output = "";
            input = "";
            output-input = "  ";
            none = "";
          };
        };

        "hyprland/language" = {
          format-en = "en";
          format-ru = "ru";
        };
      }
    ];
  };

  programs.waybar.style = ../../../.config/waybar/style.css;

  catppuccin.waybar.mode = "createLink";
}
