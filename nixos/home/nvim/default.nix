{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    extraConfigLuaPre = "require('tima')";
    colorschemes.catppuccin = {
      enable = config.catppuccin.enable;
      settings.flavour = config.catppuccin.flavor;
    };
    plugins.lazy = {
      enable = true;
      settings.defaults.lazy = true;
      plugins =
        let
          vimPlugins = import ./pkgs.nix { inherit pkgs lib; };
          plugins = (builtins.attrNames (builtins.readDir ./plugins));
          processPlugin = plugin: plugin // lib.optionalAttrs (plugin ? keys) { keys.__raw = plugin.keys; };
          processPlugins =
            plugins:
            if lib.isList plugins then
              builtins.concatMap processPlugins plugins
            else if lib.isAttrs plugins then
              [ (processPlugin plugins) ]
            else
              throw;
        in
        builtins.concatMap (plugin: processPlugins (import ./plugins/${plugin} vimPlugins)) plugins;
    };
  };
  home.file.".config/nvim/lua" = {
    source = ../../../.config/nvim/lua;
    recursive = true;
  };
  home.file.".config/nvim/after" = {
    source = ../../../.config/nvim/after;
    recursive = true;
  };
}
