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
}
