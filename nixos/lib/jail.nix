jail-nix:
pkgs:
jail-nix.lib.extend {
  inherit pkgs;
  basePermissions = combinators: with combinators; [
    base
    (ro-bind "${pkgs.coreutils}/bin/env" "/usr/bin/env")
    (add-path "/usr/bin")
    (fwd-env "COLORTERM")
    (fwd-env "LOCALE_ARCHIVE")
    (readonly (noescape ''"$LOCALE_ARCHIVE"''))
    bind-nix-store-runtime-closure
    fake-passwd
  ];
  additionalCombinators = combinators: with combinators; {
    network = { hostname }: compose [
      (set-hostname hostname)
      network
      (try-fwd-env "all_proxy")
      (try-fwd-env "ftp_proxy")
      (try-fwd-env "http_proxy")
      (try-fwd-env "https_proxy")
      (try-fwd-env "no_proxy")
      (try-fwd-env "rsync_proxy")
    ];
  };
}
