local hy3 = hl.plugin.hy3

local terminal = "alacritty"
local shell = os.getenv("SHELL") or "/usr/bin/env sh"
local lock = "swaylock -f -c 000000"

local function menu(action)
  return "wofi --show " .. action
end

hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "1.0",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
  animations = {
    enabled = false,
  },

  general = {
    layout = "hy3",

    gaps_in = 5,
    gaps_out = 0,
    border_size = 0,
    resize_on_border = true,

    snap = {
      enabled = true,
      window_gap = 10,
      monitor_gap = 10
    }
  },

  input = {
    kb_layout = "us,ru",
    kb_options = "grp:caps_toggle,compose:ralt",
    repeat_delay = 200,
    repeat_rate = 40,
    follow_mouse = 2,

    touchpad = {
      disable_while_typing = true,
      natural_scroll = true,
      tap_to_click = true,
    },
  },
})

hl.config({
  plugin = {
    hy3 = {
      tabs = {
        blur = false,
      },
    },
  },
})

hl.device({
  name = "1386:21073:Wacom_HID_5251_Finger",
  output = "eDP-1",
})

hl.device({
  name = "1386:21073:Wacom_HID_5251_Pen",
  output = "eDP-1",
})

hl.workspace_rule({
  workspace = "name:0",
  monitor = "eDP-1",
})

hl.on("hyprland.start", function()
  -- TODO: wallpaper
  -- hl.exec_cmd("pkill swaybg; swaybg -i wallpaper.png -m fill &")
  hl.exec_cmd("pkill kanshi; kanshi &")
  hl.exec_cmd("pkill wvkbd-mobintl; wvkbd-mobintl --hidden &")
  hl.exec_cmd("waybar &")
  hl.exec_cmd("wljoywake")
  -- TODO: audio idle inhibitor, idle lock
  -- hl.exec_cmd("sway-audio-idle-inhibit")
  -- hl.exec_cmd("swayidle -w timeout 600 '" .. lock .. "' timeout 600 'swaymsg \"output * power off\"' resume 'swaymsg \"output * power on\"' before-sleep '" .. lock .. "'")
end)

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal .. " -e " .. shell))
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(lock))
-- TODO: popup with warning on exit
-- hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'hyprctl dispatch exit'"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(
  "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
))

hl.bind(mainMod .. " + O", hl.dsp.submap("open"))
hl.bind(mainMod .. " + N", hl.dsp.submap("notifications"))
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

local directions = {
  left = "H",
  down = "J",
  up = "K",
  right = "L",
}

for direction, vimkey in pairs(directions) do
  hl.bind(mainMod .. " + " .. direction, hy3.move_focus(direction))
  hl.bind(mainMod .. " + " .. vimkey, hy3.move_focus(direction))

  hl.bind(mainMod .. " + SHIFT + " .. direction, hy3.move_window(direction))
  hl.bind(mainMod .. " + SHIFT + " .. vimkey, hy3.move_window(direction))
end

for i = 0, 9 do
  local ws = "name:" .. tostring(i)
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = ws }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hy3.move_to_workspace(ws, { follow = false }))
end

hl.bind(mainMod .. " + B", hy3.make_group("h"))
hl.bind(mainMod .. " + V", hy3.make_group("v"))
hl.bind(mainMod .. " + S", hy3.make_group("tab"))
hl.bind(mainMod .. " + W", hy3.change_group("tab"))
hl.bind(mainMod .. " + E", hy3.change_group("opposite"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + CTRL + F", function ()
  local win = hl.get_active_window()
  if not win then return end
  local client = win.fullscreen_client == 0 and 2 or 0 --[[ 0 = none, 2 = fullscreen ]]
  hl.dispatch(hl.dsp.window.fullscreen_state( { internal = win.fullscreen , client = client }))
end)
hl.bind(mainMod .. " + D", hy3.toggle_focus_layer())
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + A", hy3.change_focus("raise"))
hl.bind(mainMod .. " + I", hy3.change_focus("lower"))

hl.bind(mainMod .. " + Q", hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + SHIFT + Q", hy3.move_to_workspace("special:", { follow = false }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("Print",
  hl.dsp.exec_cmd(
    [[mkdir -p "$(xdg-user-dir SCREENSHOTS)/$(date '+%Y/%B')" && wl-copy <$(grimshot --notify save area "$(xdg-user-dir SCREENSHOTS)/$(date '+%Y/%B/Screenshot_from_%Y-%m-%d_%H-%M-%S.png')")]]))

hl.define_submap("notifications", "reset", function()
  hl.bind("c", hl.dsp.exec_cmd("dunstctl close-all"))
  hl.bind("t", hl.dsp.exec_cmd("dunstctl set-paused toggle"))
  hl.bind("Return", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.submap("reset"))
  hl.bind(mainMod .. " + N", hl.dsp.submap("reset"))
end)

hl.define_submap("resize", "reset", function()
  -- TODO:
  -- hl.bind("Left", hl.dsp.window.resize({ x = -10, relative = true }))
  -- hl.bind("Down", hl.dsp.window.resize({ y = 10, relative = true }))
  -- hl.bind("Up", hl.dsp.window.resize({ y = -10, relative = true }))
  -- hl.bind("Right", hl.dsp.window.resize({ x = 10, relative = true }))
  hl.bind("Return", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.submap("reset"))
  hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

hl.define_submap("open", "reset", function()
  hl.bind("a", hl.dsp.exec_cmd(menu("drun")))
  hl.bind("c", hl.dsp.exec_cmd(menu("run")))
  hl.bind("t", hl.dsp.exec_cmd("Telegram"))
  hl.bind("b", hl.dsp.exec_cmd("brave-browser"))
  hl.bind("f", hl.dsp.exec_cmd("firefox"))
  hl.bind("z", hl.dsp.exec_cmd("zathura"))
  hl.bind("k", hl.dsp.exec_cmd("command kill -s RTMIN $(pgrep wvkbd-mobintl)"))
  hl.bind("d", hl.dsp.exec_cmd("discord"))
  hl.bind("o", hl.dsp.exec_cmd("obsidian"))
  hl.bind("Return", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.submap("reset"))
  hl.bind(mainMod .. " + O", hl.dsp.submap("reset"))
end)

hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})
