{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "ivpn-iptables-wrapper";
  version = "1";

  dontUnpack = true;

  installPhase = ''
    mkdir -p "$out/bin"

    # IVPN firewall scripts may call any of these binaries.
    for bin in iptables ip6tables iptables-save iptables-restore ip6tables-save ip6tables-restore; do
      cat > "$out/bin/$bin" <<'EOF'
#!/usr/bin/env sh
exit 0
EOF
      chmod +x "$out/bin/$bin"
    done
  '';
}
