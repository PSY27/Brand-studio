#!/bin/bash
# Export a square, full-bleed SVG icon (no rounded corners; the OS adds its mask)
# to app-store PNG sizes.
# usage: export-icons.sh <icon.svg> <outdir> [name]
#   makes <name>-1024/512/192.png
#   if name is "favicon" also makes favicon-32.png, favicon-16.png, apple-touch-180.png
set -e
SVG="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"; OUT="$2"; N="${3:-$(basename "$1" .svg)}"
mkdir -p "$OUT"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1024,1024 --default-background-color=00000000 --screenshot="$OUT/$N-1024.png" "file://$SVG" 2>/dev/null
for s in 512 192; do sips -z $s $s "$OUT/$N-1024.png" --out "$OUT/$N-$s.png" >/dev/null; done
if [ "$N" = "favicon" ]; then
  sips -z 32 32 "$OUT/$N-1024.png" --out "$OUT/favicon-32.png" >/dev/null
  sips -z 16 16 "$OUT/$N-1024.png" --out "$OUT/favicon-16.png" >/dev/null
  sips -z 180 180 "$OUT/$N-1024.png" --out "$OUT/apple-touch-180.png" >/dev/null
fi
echo "exported to $OUT"
