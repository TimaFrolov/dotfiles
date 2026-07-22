{ config, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;

  opencode-sandbox = pkgs.writeShellApplication {
    name = "opencode";
    text = ''
      exec ${pkgs.bubblewrap}/bin/bwrap \
        --ro-bind "${homeDir}/.config/opencode" "${homeDir}/.config/opencode" \
        --ro-bind "${homeDir}/.config/git" "${homeDir}/.config/git" \
        --ro-bind /nix /nix \
        --ro-bind /etc /etc \
        --ro-bind /run/current-system/sw /run/current-system/sw \
        --bind "${homeDir}/.local/share/opencode" "${homeDir}/.local/share/opencode" \
        --bind "${homeDir}/.cache/opencode" "${homeDir}/.cache/opencode" \
        --bind "$PWD" "$PWD" \
        --dev /dev \
        --proc /proc \
        --die-with-parent \
        -- \
        ${pkgs.opencode}/bin/opencode "$@"
    '';

    meta = pkgs.opencode.meta;
  };
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
          "git status" = "allow";
          "git log*" = "allow";
          "git diff*" = "allow";
          "git show*" = "allow";
          "git ls-files*" = "allow";
          "git blame*" = "allow";
          "git reflog*" = "allow";
          "git config list --*" = "allow";
          "git config get --*" = "allow";
          "git branch --show-current" = "allow";
          "git add *" = "allow";
          "git pr diff *" = "allow";
          "git pr view *" = "allow";
          "gh pr list *" = "allow";
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
          "cut *" = "allow";
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

        input_submit = "ctrl+s,<leader>return";
        input_newline = "return";
        input_move_left = "ctrl+b";
        input_move_right = "ctrl+f";
        input_line_home = "ctrl+a";
        input_line_end = "ctrl+e";

        messages_page_up = "ctrl+u";
        messages_page_down = "ctrl+d";

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
    '';
  };
}
