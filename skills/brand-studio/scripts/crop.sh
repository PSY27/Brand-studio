#!/bin/bash
# Crop (and optionally upscale) part of a screenshot to inspect detail (macOS sips).
# usage: crop.sh <in.png> <out.png> <x> <y> <w> <h> [scale]
# Note: sips --cropOffset takes "Y X" (row first). This wrapper takes x then y.
IN="$1"; OUT="$2"; X="$3"; Y="$4"; W="$5"; H="$6"; S="${7:-1}"
sips -c "$H" "$W" --cropOffset "$Y" "$X" "$IN" --out "$OUT" >/dev/null
if [ "$S" != "1" ]; then sips -z $((H*S)) $((W*S)) "$OUT" --out "$OUT" >/dev/null; fi
echo "$OUT"
