#!/bin/bash
# Check domain registration via public RDAP (whois is often blocked in sandboxes).
# usage: check-domains.sh name.com name.in name.co ...
#   200 = registered (prints dates). 404 = no record = likely available.
#   Always confirm at a registrar before buying.
# Sanity-check first with a known name (e.g. google.in) so you know the TLD answers.
TMPJ="$(pwd)/.rdap-check.json"
for d in "$@"; do
  code=$(curl -sL -o "$TMPJ" -w "%{http_code}" --max-time 12 "https://rdap.org/domain/$d")
  if [ "$code" = 200 ]; then
    python3 -I -c "import json,sys;d=json.load(open(sys.argv[1]));ev={e['eventAction']:e['eventDate'][:10] for e in d.get('events',[])};print(sys.argv[2]+': TAKEN (registered',ev.get('registration','?'),'expires',ev.get('expiration','?')+')')" "$TMPJ" "$d"
  elif [ "$code" = 404 ]; then echo "$d: no record, likely AVAILABLE"
  else echo "$d: unknown (http $code, retry later)"; fi
done
