jail-nix: pkgs:
let
  helpers = import "${jail-nix}/lib/helpers.nix" pkgs;
in
jail-nix.lib.extend {
  inherit pkgs;
  basePermissions =
    combinators: with combinators; [
      base
      (ro-bind "${pkgs.coreutils}/bin/env" "/usr/bin/env")
      (add-path "/usr/bin")
      (fwd-env "COLORTERM")
      (fwd-env "LOCALE_ARCHIVE")
      (readonly (noescape ''"$LOCALE_ARCHIVE"''))
      bind-nix-store-runtime-closure
      fake-passwd
    ];
  additionalCombinators =
    combinators: with combinators; {
      network =
        { hostname }:
        compose [
          (set-hostname hostname)
          network
          (try-fwd-env "all_proxy")
          (try-fwd-env "ftp_proxy")
          (try-fwd-env "http_proxy")
          (try-fwd-env "https_proxy")
          (try-fwd-env "no_proxy")
          (try-fwd-env "rsync_proxy")
        ];
      readonly-paths-from-var =
        var: separator:
        let
          runtime-var = "RUNTIME_READONLY_${var}";
        in
        assert pkgs.lib.isValidPosixName var;
        include-once "readonly-paths-from-var-${var}" (compose [
          (add-runtime ''
            ${runtime-var}=()
            IFS=${pkgs.lib.escapeShellArg separator} read -ra DIRS <<< "''${${var}-}"
            if ((''${#DIRS[@]})); then
              while IFS= read -r -d ''' P; do
                ${runtime-var}+=(--ro-bind "$P" "$P")
              done < <(realpath -ezq -- "''${DIRS[@]}")
            fi
          '')
          (unsafe-add-raw-args ''"''${${runtime-var}[@]}"'')
        ]);
      persist =
        name: path:
        let
          realPath = helpers.dataDirSubPath "persistent/${name}/${escape path}";
        in
        compose [
          (add-runtime "mkdir -p ${realPath}")
          (rw-bind (noescape realPath) path)
        ];
      create-readwrite =
        path:
        compose [
          (add-runtime "mkdir -p ${escape path}")
          (readwrite path)
        ];
    };
}
