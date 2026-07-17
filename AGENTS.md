# Repository

NixOS dotfiles managed via a single Nix flake with home-manager.

## Key commands

- `nix flake check ~/dotfiles` — validate all configurations (no sudo needed)
- `nixos-rebuild --flake ~/dotfiles --sudo switch` — apply changes to the running system
- New files must be `git add`'d before Nix can access them (flake evaluates only tracked files)

## Structure

- `flake.nix` — defines all nixosConfigurations and homeConfigurations
- `nixos/bundle/` — reusable NixOS module groups (minimal, core, desktop, dev-*, etc.)
- `nixos/package/` — individual NixOS package modules (catppuccin, neovim, etc.)
- `nixos/home/bundle/` — reusable home-manager module groups
- `nixos/home/package/` — individual home-manager package modules
- `nixos/config/<machine>/` — per-machine hardware and system configuration
- `nixos/home.nix` — home-manager entry point
- `.config/` — user dotfiles (hyprland, sway, waybar, neovim, git, lf)
- `scripts/` — shell utilities (workspace-manager, vdp, xdg-terminal-exec)
- `.tmux/`, `.zsh/`, `.config/alacritty/`, `.config/waybar/` — git submodules (catppuccin themes, tpm)

## Conventions

- Theme: Catppuccin Mocha everywhere, lavender accent (configured in `nixos/package/catppuccin.nix`)
- Local overrides use gitignored files: `local.nix`, `local/.gitconfig`, `local.conf`
- To add a package: create a module in `nixos/package/` or `nixos/home/package/`, then import in the relevant config
- Vi/vim keybindings throughout (zsh, tmux, neovim, sway, hyprland)

## Keybinding zones

Modifier keys are reserved per layer. Never use a reserved modifier in a different layer's config.

- **Alt** — reserved for tmux (prefix keys, window/pane navigation)
- **Ctrl+Alt** — reserved for the terminal emulator (alacritty: font size, window actions)
- **Ctrl** — reserved for specific programs (neovim, opencode, lazygit, zsh, etc.)
