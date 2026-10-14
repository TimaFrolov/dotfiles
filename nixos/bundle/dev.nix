{
  pkgs,
  ...
}:
{
  tima.dev.enable = true;
  imports = [ ../package/neovim.nix ];

  security.lsm = [ "selinux" ];
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
    git-lfs
    vbindiff
    pwntools
    tokei
    gdb
    prettierd
    nixd
    bubblewrap
    nixfmt
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
