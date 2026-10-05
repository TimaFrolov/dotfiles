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
        mount-cwd-git-dir =
          var-rw:
          let
            runtime-var = "RUNTIME_GITDIR";
            bind-pwd = ''${runtime-var}+=(--bind "$PWD" "$PWD")'';
            bind-gitdir =
              if var-rw != null then
                ''
                  case "''${${var-rw}-}" in
                    1) ${runtime-var}+=(--bind "$GIT_DIR" "$GIT_DIR") ;;
                    *) ${runtime-var}+=(--ro-bind "$GIT_DIR" "$GIT_DIR") ;;
                  esac
                ''
              else
                ''${runtime-var}+=(--ro-bind "$GIT_DIR" "$GIT_DIR")'';
          in
          assert var-rw == null || lib.isValidPosixName var-rw;
          include-once "mount-cwd-git-dir" (compose [
            (add-runtime ''
              ${runtime-var}=()
              if GIT_DIR=$(${lib.getExe pkgs.git} rev-parse --git-common-dir 2>/dev/null); then
                GIT_DIR=$(realpath -e "$GIT_DIR")
                PWD_REAL=$(realpath -e "$PWD")

                GIT_DIR_IS_SUBDIR_OF_PWD=false
                case "$GIT_DIR" in
                  "$PWD_REAL" | "$PWD_REAL"/*) GIT_DIR_IS_SUBDIR_OF_PWD=true ;;
                esac

                if $GIT_DIR_IS_SUBDIR_OF_PWD; then ${bind-pwd}; fi
                ${bind-gitdir}
                if (! $GIT_DIR_IS_SUBDIR_OF_PWD); then ${bind-pwd}; fi
              else
                ${bind-pwd}
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
        add-ro-bin-path =
          path:
          compose [
            (readonly path)
            (add-path "${path}/bin")
          ];
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
