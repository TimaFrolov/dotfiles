jail-nix: pkgs:
let
  inherit (pkgs) lib;
  helpers = import "${jail-nix}/lib/helpers.nix" pkgs;
  jail = jail-nix.lib.extend {
    inherit pkgs;
    basePermissions =
      combinators: with combinators; [
        (unsafe-add-raw-args ''--uid "$HOST_UID" --gid "$HOST_GID"'')
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
          ];
        readonly-paths-from-var =
          var: separator:
          let
            runtime-var = "RUNTIME_READONLY_${var}";
          in
          assert lib.isValidPosixName var;
          include-once "readonly-paths-from-var-${var}" (compose [
            (add-runtime ''
              ${runtime-var}=()
              IFS=${lib.escapeShellArg separator} read -ra DIRS <<< "''${${var}-}"
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
        runtime-args = include-once "runtime-args" (add-runtime ''
          for arg in "$@"; do
            if [[ "$arg" = "--" ]]; then
              shift
              break
            fi
            RUNTIME_ARGS+=("$arg")
            shift
          done
        '');
      };
  };
in
jail
// {
  __functor =
    _: name: exe: permissions:
    pkgs.writeShellApplication {
      inherit name;
      text = ''
        HOST_UID=$(id -u) HOST_GID=$(id -g) exec ${pkgs.rootlesskit}/bin/rootlesskit \
          --copy-up=/etc --net=slirp4netns --disable-host-loopback --cidr 10.0.2.0/24 \
          -- ${pkgs.writeShellScript "${name}-nft" ''
            set -o errexit
            set -o nounset
            set -o pipefail
            ${lib.getExe pkgs.nftables} -f ${./bogon.nft}
            exec ${lib.getExe (jail "${name}-inner" exe permissions)} "$@"
          ''} "$@"
      '';
      runtimeInputs = [
        pkgs.coreutils
        pkgs.slirp4netns
      ];
    };
}
