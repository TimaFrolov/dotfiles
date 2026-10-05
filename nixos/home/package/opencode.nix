{
  pkgs,
  lib,
  config,
  osConfig,
  jail,
  ...
}:
let
  opencode-sandbox = jail pkgs "opencode" pkgs.opencode (
    combinators:
    with combinators;
    lib.optional (osConfig.networking or { } ? hostName) (set-hostname osConfig.networking.hostName)
    ++ [
      network
      no-new-session
      (fwd-env "EDITOR")

      (readonly (noescape "~/.config/opencode"))
      (readonly (noescape "~/.local/share/nix/trusted-settings.json"))
      # (readonly (noescape "~/.config/git"))
      (persist "opencode" (noescape "~/.config/gh"))
      (persist "opencode" (noescape "~/.config/git"))

      (readwrite (noescape "~/.local/share/opencode"))
      (readwrite (noescape "~/.local/state/opencode"))
      (readwrite (noescape "~/.cache/opencode"))
      (create-readwrite (noescape "~/.local/share/uv"))
      (create-readwrite (noescape "~/.cache/uv"))

      (readonly-paths-from-var "ROBIND_DIRS" ":")
      (mount-cwd-git-dir "GITDIR_RW")

      (readonly "/nix")
      (readonly "/etc/nix")
      (readonly "/etc/static/nix")
      (add-ro-bin-path "/run/current-system/sw")
      (add-ro-bin-path "/etc/profiles/per-user/${config.home.username}")
    ]
    ++ lib.optional (osConfig.programs.nix-ld.enable or false) (readonly "/lib64")
  );
in
{
  programs.opencode = {
    enable = true;

    package = opencode-sandbox;

    settings = {
      model = "nano-gpt/qwen/qwen3.8-flash";

      share = "manual";
      autoupdate = false;

      provider."llama-desktop" = {
        npm = "@ai-sdk/openai-compatible";
        options.baseURL = "http://desktop.timafrolov.me:8080/v1";
        models."qwen" = { };
      };

      provider."nano-gpt" = builtins.fromJSON (builtins.readFile ./opencode/nano-gpt.json);

      formatter = true;
      lsp = true;

      permission = {
        edit = "allow";
        read = "allow";
        bash."*" = "allow";
        webfetch = "allow";
        websearch = "allow";
        external_directory = "allow";
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
      # NixOS environment rules

      ## System config
      - Do not modify global system configuration (e.g. /etc/nixos,
        nixos-rebuild, system packages) unless the user explicitly asks.

      ## Dependencies
      - When compiling or building projects that don't use Nix, use
        `nix shell` to pull in dependencies rather than assuming a
        traditional package manager.
      - For Python projects, prefer `uv` over pip/poetry/conda.
        When using `uv`, prefer virtual environments (uv venv / uv run)
        over system-wide package management.

      ## Data sources
      - When user gives you private github link - use `gh api`.
      - If you need to get data from json object - use `jq` instead of
        custom python scripts.

      ## Nix store
      - Avoid using `find` in `/nix/store` - it's extremely large and
        operations will be very slow. Use `nix` commands to get
        information about relevant paths. (e.g. nix flake metadata --json)
      - To get the local store path of a flake input, use:
        `nix eval --expr "(builtins.getFlake (toString ./.))" --apply 'flake: flake.inputs.<input-name>.outPath' --raw --impure`

      # Session efficiency rules (code review sessions)

      ## Diff review
      - For PRs >500 changed lines: get `git diff --stat` first, then delegate
        area-scoped reviews to parallel subagents; main context reads only the
        1-2 files where a bug is suspected.
      - Never page through a large diff with head/sed slices.

      ## Builds
      - Always capture build output to a file:
        `nix build ... >/dev/null 2>/tmp/nix.log || tail -20 /tmp/nix.log`
        (fetch progress bars can dominate context).

      ## Tool hygiene
      - One query per fact; cache results in-conversation. No near-duplicate greps.

      ## Persistence
      - Write findings + reproducers to a scratch file (tmp/) as soon as confirmed;
        enables cheap resumption after context compaction.
    '';
  };
}
