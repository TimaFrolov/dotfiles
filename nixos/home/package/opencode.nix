{
  pkgs,
  lib,
  osConfig,
  jail,
  ...
}:
let
  opencode-sandbox = jail pkgs "opencode" pkgs.opencode (
    combinators:
    with combinators;
    [
      (network { hostname = osConfig.networking.hostName; })
      no-new-session
      (fwd-env "EDITOR")

      (readonly (noescape "~/.config/opencode"))
      # (readonly (noescape "~/.config/git"))
      (persist "opencode" (noescape "~/.config/gh"))
      (persist "opencode" (noescape "~/.config/git"))

      (readwrite (noescape "~/.local/share/opencode"))
      (readwrite (noescape "~/.local/state/opencode"))
      (readwrite (noescape "~/.cache/opencode"))
      (create-readwrite (noescape "~/.local/share/uv"))
      (create-readwrite (noescape "~/.cache/uv"))

      (readonly-paths-from-var "ROBIND_DIRS" ":")
      mount-cwd

      (readonly "/nix")
      (readonly "/etc/nix")
      (readonly "/etc/static/nix")
      (readonly "/run/current-system/sw/")
      (add-path "/run/current-system/sw/bin/")
    ]
    ++ lib.optional osConfig.programs.nix-ld.enable (readonly "/lib64")
  );
in
{
  programs.opencode = {
    enable = true;

    package = opencode-sandbox;

    settings = {
      model = "opencode/big-pickle";

      share = "manual";
      autoupdate = false;

      formatter = true;
      lsp = true;

      permission = {
        edit = "allow";
        read = "allow";
        bash = {
          "git status *" = "allow";
          "git log*" = "allow";
          "git diff*" = "allow";
          "git show*" = "allow";
          "git ls-files*" = "allow";
          "git blame*" = "allow";
          "git reflog*" = "allow";
          "git config list --*" = "allow";
          "git config get --*" = "allow";
          "git branch --show-current" = "allow";
          "git branch -a" = "allow";
          "git add *" = "allow";
          "git pr diff *" = "allow";
          "git pr view *" = "allow";
          "git remote -v" = "allow";
          "gh pr list *" = "allow";
          "gh run view *" = "allow";
          "gh run list *" = "allow";
          "gh run watch *" = "allow";
          "gh api *" = "allow";
          "gh auth status *" = "allow";
          "nix *" = "allow";
          "uv *" = "allow";
          "find *" = "allow";
          "grep *" = "allow";
          "rg *" = "allow";
          "which *" = "allow";
          "readlink *" = "allow";
          "file *" = "allow";
          "strings *" = "allow";
          "type *" = "allow";
          "echo *" = "allow";
          "pwd" = "allow";
          "env *" = "allow";
          "ls *" = "allow";
          "cat *" = "allow";
          "sort *" = "allow";
          "head *" = "allow";
          "tail *" = "allow";
          "wc *" = "allow";
          "awk *" = "allow";
          "jq *" = "allow";
          "cut *" = "allow";
          "base64 *" = "allow";
          "sed *" = "allow";
          "tr *" = "allow";
          "sleep *" = "allow";
          "date *" = "allow";
          "read *" = "allow";
          "test *" = "allow";
          "break *" = "allow";
          "mktemp *" = "allow";
          "home-manager *" = "allow";
          "*" = "ask";
        };
        webfetch = "allow";
        websearch = "allow";
        external_directory = {
          "/nix/store/*" = "allow";
          "/tmp/*" = "allow";
        };
      };
    };

    tui = {
      leader_timeout = 2000;
      keybinds = {
        leader = "ctrl+x";

        input_submit = "ctrl+s,ctrl+return,<leader>return";
        input_newline = "return";
        input_move_left = "ctrl+b";
        input_move_right = "ctrl+f";
        input_line_home = "ctrl+a";
        input_line_end = "ctrl+e";

        messages_page_up = "ctrl+u";
        messages_page_down = "ctrl+d";
        messages_line_up = "ctrl+k";
        messages_line_down = "ctrl+j";

        "dialog.select.prev" = "k";
        "dialog.select.next" = "j";
        "prompt.autocomplete.prev" = "k";
        "prompt.autocomplete.next" = "j";

        session_new = "<leader>n";
        session_list = "<leader>l";
        session_compact = "<leader>c";
        session_undo = "<leader>u";
        session_redo = "<leader>r";
        messages_copy = "<leader>y";

        sidebar_toggle = "<leader>b";
        model_list = "<leader>m";
        agent_list = "<leader>a";
        command_list = "ctrl+p";
        editor_open = "<leader>e";

        display_thinking = "<leader>t";
        tool_details = "<leader>o";
        theme_list = "none";

        session_parent = "up,k";
        session_child_first = "<leader>down,<leader>j";
        session_child_cycle = "right,l";
        session_child_cycle_reverse = "left,h";

        session_interrupt = "escape";
        app_exit = "ctrl+c,<leader>q";
      };
    };

    context = ''
      This system is NixOS-based. Do not modify global system
      configuration (e.g. /etc/nixos, nixos-rebuild, system packages)
      unless the user explicitly asks you to.

      When compiling or building projects that don't use Nix, use
      `nix shell` to pull in dependencies rather than assuming a
      traditional package manager.

      For Python projects, prefer `uv` over pip/poetry/conda.
      When using `uv`, prefer virtual environments (uv venv / uv run)
      over system-wide package management.

      Avoid using `find` in `/nix/store` - it's extremely large and operations will be very slow.
      Use `nix` commands to get information about relevant paths. (e.g. nix flake metadata --json)

      To get the local store path of a flake input, use:
      `nix eval --expr "(builtins.getFlake (toString ./.))" --apply 'flake: flake.inputs.<input-name>.outPath' --raw --impure`
    '';
  };
}
