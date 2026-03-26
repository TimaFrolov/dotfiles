set -euo pipefail

IP="$(command -v ip)"
MARK="${IVPN_MARK:?IVPN_MARK is required}"
TABLE="${IVPN_TABLE:?IVPN_TABLE is required}"
PRIO="${IVPN_RULE_PRIORITY:?IVPN_RULE_PRIORITY is required}"
MAIN_PRIO="${MAIN_RULE_PRIORITY:?MAIN_RULE_PRIORITY is required}"

IFACES_RAW="${IVPN_IFACES:-}"
if [[ -z "$IFACES_RAW" ]]; then
  IFACES_RAW="${IVPN_IFACE:?IVPN_IFACE is required}"
fi

# systemd Environment entries cannot safely carry unquoted spaces,
# so module config passes interface lists as comma-separated values.
IFACES_RAW="${IFACES_RAW//,/ }"

read -r -a IFACES <<< "$IFACES_RAW"

find_active_iface() {
  local iface
  for iface in "${IFACES[@]}"; do
    if "$IP" link show dev "$iface" >/dev/null 2>&1; then
      printf '%s\n' "$iface"
      return 0
    fi
  done

  return 1
}

ensure_rules() {
  "$IP" -4 rule add not fwmark "$MARK" table main priority "$MAIN_PRIO" 2>/dev/null || true
  "$IP" -6 rule add not fwmark "$MARK" table main priority "$MAIN_PRIO" 2>/dev/null || true
  "$IP" -4 rule add fwmark "$MARK" table "$TABLE" priority "$PRIO" 2>/dev/null || true
  "$IP" -6 rule add fwmark "$MARK" table "$TABLE" priority "$PRIO" 2>/dev/null || true
}

ensure_routes() {
  local iface="$1"
  "$IP" -4 route replace default dev "$iface" table "$TABLE"
  "$IP" -6 route replace default dev "$iface" table "$TABLE" || true
}

prune_main_table_iface_routes() {
  local iface="$1"
  local route

  while IFS= read -r route; do
    [[ -n "$route" ]] || continue
    "$IP" -4 route del table main $route 2>/dev/null || true
  done < <("$IP" -4 route show table main dev "$iface" 2>/dev/null || true)

  while IFS= read -r route; do
    [[ -n "$route" ]] || continue
    "$IP" -6 route del table main $route 2>/dev/null || true
  done < <("$IP" -6 route show table main dev "$iface" 2>/dev/null || true)
}

cleanup() {
  "$IP" -4 rule del not fwmark "$MARK" table main priority "$MAIN_PRIO" 2>/dev/null || true
  "$IP" -6 rule del not fwmark "$MARK" table main priority "$MAIN_PRIO" 2>/dev/null || true
  "$IP" -4 rule del fwmark "$MARK" table "$TABLE" priority "$PRIO" 2>/dev/null || true
  "$IP" -6 rule del fwmark "$MARK" table "$TABLE" priority "$PRIO" 2>/dev/null || true
  "$IP" -4 route flush table "$TABLE" 2>/dev/null || true
  "$IP" -6 route flush table "$TABLE" 2>/dev/null || true
}

trap cleanup EXIT

while true; do
  if active_iface="$(find_active_iface)"; then
    prune_main_table_iface_routes "$active_iface"
    ensure_rules
    ensure_routes "$active_iface"
  else
    cleanup
  fi

  sleep 2
done
