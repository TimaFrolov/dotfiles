#!/usr/bin/env bash
set -euo pipefail

ASN_LIST="${ASN_LIST:?ASN_LIST is required}"
MARK="${IVPN_MARK:?IVPN_MARK is required}"

IFS=',' read -r -a ASNS <<< "$ASN_LIST"

TMPFILE="$(mktemp)"
trap 'rm -f "$TMPFILE"' EXIT

nft delete table inet ivpn 2>/dev/null || true

SET_ELEMENTS="$(bgpq4 -4 -F "%n/%l\n" "${ASNS[@]}" | \
  iprange --optimize | \
  sed 's/^/      /; s/$/,/' | \
  sed '$ s/,$//')"

{
  echo "table inet ivpn {"
  echo ""
  echo "  set ivpn4 {"
  echo "    type ipv4_addr;"
  echo "    flags interval;"
  echo "    elements = {"
  echo "$SET_ELEMENTS"
  echo "    }"
  echo "  }"
  echo ""
  echo "  chain output {"
  echo "    type route hook output priority mangle; policy accept;"
  echo "    ip daddr @ivpn4 meta mark set $MARK"
  echo "  }"
  echo ""
  echo "  chain postrouting {"
  echo "    type nat hook postrouting priority srcnat; policy accept;"
  echo "    meta mark $MARK masquerade"
  echo "  }"
  echo "}"
} > "$TMPFILE"

if ! nft -f "$TMPFILE"; then
  echo "Failed to load nftables ruleset:" >&2
  cat "$TMPFILE" >&2
  exit 1
fi
