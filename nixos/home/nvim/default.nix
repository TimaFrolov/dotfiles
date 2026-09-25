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
          plugins = import ./pkgs.nix pkgs;
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
        builtins.readDir ./plugins
        |> builtins.attrNames
        |> map (plugin: (import ./plugins/${plugin} { inherit pkgs plugins; }))
        |> builtins.concatMap processPlugins;
    };
  };
  xdg.configFile."nvim/lua" = {
    source = ../../../.config/nvim/lua;
    recursive = true;
  };
  xdg.configFile."nvim/after" = {
    source = ../../../.config/nvim/after;
    recursive = true;
  };
}
