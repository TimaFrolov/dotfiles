{
  pkgs,
  lib,
  config,
  osConfig,
  jail,
  ...
}:
{
  home.packages = [
    (jail pkgs "jail" osConfig.users.users.${config.home.username}.shell (
      combinators:
      with combinators;
      [
        no-new-session
        (fwd-env "EDITOR")
        (readonly (noescape "~/.config/nvim"))
        (readwrite (noescape "~/.local/share/nvim"))
        (readonly (noescape "~/.zsh"))
        (readonly (noescape "~/.zshrc"))
        (readwrite (noescape "~/.zsh_history"))
        (create-readwrite (noescape "~/.local/share/uv"))
        (create-readwrite (noescape "~/.cache/uv"))

        (readonly-paths-from-var "ROBIND_DIRS" ":")
        mount-cwd

        (readonly "/nix")
        (readonly "/etc/nix")
        (readonly "/etc/static/nix")
        (readonly "/run/current-system/sw/")
        (readonly "/etc/profiles/per-user/${config.home.username}/")
        (fwd-env "PATH")
        runtime-args
      ]
      ++ lib.optional osConfig.programs.nix-ld.enable (readonly "/lib64")
    ))

  ];
}
