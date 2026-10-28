#!/bin/bash
# Screenshot an HTML or SVG file with headless Chrome.
# usage: shot.sh <file.html> <out.png> [width] [height] [budget_ms] [--static]
#   --static  writes a copy with CSS animations off into .brand-tmp/ next to the
#             input (so every mark shows its final state) and screenshots that.
set -e
IN="$1"; OUT="$2"; W="${3:-1280}"; H="${4:-1400}"; B="${5:-6000}"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || CHROME="$(command -v google-chrome || command -v chromium || true)"
[ -n "$CHROME" ] || { echo "Chrome not found"; exit 1; }
SRC="$(cd "$(dirname "$IN")" && pwd)/$(basename "$IN")"
if [ "$6" = "--static" ]; then
  DIR="$(dirname "$SRC")"; mkdir -p "$DIR/.brand-tmp"
  STATIC="$DIR/.brand-tmp/$(basename "${SRC%.html}").static.html"
  # rewrite relative asset paths so the copy still finds svg/ and png/
  sed -e 's|</style>|*{animation:none!important}</style>|' -e "s|=\"svg/|=\"$DIR/svg/|g" -e "s|=\"png/|=\"$DIR/png/|g" "$SRC" > "$STATIC"
  SRC="$STATIC"
fi
"$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size="$W,$H" --virtual-time-budget="$B" --screenshot="$OUT" "file://$SRC" 2>/dev/null
echo "$OUT"
