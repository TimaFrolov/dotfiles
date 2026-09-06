{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.sensible ];
    extraConfig = builtins.readFile ../../../.config/tmux/tmux.conf;
  };
  catppuccin.tmux.extraConfig = builtins.readFile ../../../.config/tmux/catppuccin.conf;
}
