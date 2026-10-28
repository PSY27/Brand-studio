# Lessons: bugs and mistakes that cost the most time

## SVG and CSS
- **CSS cannot animate inside `<use>`.** Selectors like `.logo.play .part` do not
  reach the shadow tree of `<use href="#mark">`. Inline the markup instead:
  `svg.innerHTML = template.innerHTML`.
- **Transform origin on SVG children.** Use `transform-box: fill-box;
  transform-origin: center` for pops and spins. For an element positioned with
  `translate(x,y) scale(s)`, choose the origin up front: with `0 0`, a `rotate()`
  swings it around its corner and it flies off-screen. For spinning elements use
  `transform-origin: 50% 50%` and translate to (centre minus half size).
- **Duplicate `clipPath` ids** across repeated tiles break clipping. Generate a
  unique id per render (`'c' + (UID++)`).
- **Empty inline-block spacers have no height.** If you measure a spacer to place
  a mark, give it `height:1em; vertical-align:top`, or its top is the baseline.
- **Specificity ties.** A generic rule added later silently overrides an earlier
  specific size rule of equal specificity. Qualify the specific one.
- Use `pathLength="1"` + `stroke-dasharray:1 1` for draw-on strokes.
- Thick strokes eat letters: a ring drawn around text needs a thin stroke and a
  diameter well above the text width.

## Web Animations API (element.animate)
- **Do not put `easing` in the timing options of a multi-keyframe timeline.** It
  warps the whole timeline, so offsets stop meaning milliseconds. Put `easing` on
  individual keyframes.
- Store animations in an array (`root._a` or a global) and `cancel()` them before replaying.
- **Resize handlers kill animations.** Mobile URL-bar collapse and headless capture
  both fire `resize`. Re-layout only when the width actually changed and no
  animation is running.
- Measure target positions at run time with `getBoundingClientRect`, after
  `document.fonts.load(...)` resolves.
- `fill` and `stroke` are animatable; use them for colour swaps on SVG parts.

## Fonts and measurement
- Load with `document.fonts.load('700 100px "Font"', 'chars')` before measuring.
- Where a symbol replaces a dot, use the dotless form of the letter (for i,
  U+0131 `ı`); most Google Fonts include it.
- Baseline inside a `line-height:1` inline-block:
  `base = (1 - (A + D)) / 2 + A` with `A`, `D` from
  `measureText().fontBoundingBoxAscent / Descent`, divided by font size.
- Request variable ranges on Google Fonts (`wght@400..900`) and clamp per family.

## Icon motion with a knocked-out object
- **Bring the container back before shrinking the object into it.** A cut-out
  object has the background colour; if it shrinks back before the container
  returns, its inner details float on nothing.
- Swap the object's fill (and its details' fills) while it moves out, and swap back
  only once the container is behind it again.
- A tool drawn in the same colour as the details it passes over disappears. Give
  its glass or frame a tinted fill (background colour around 50% on light themes,
  white around 18% on dark).
- Let the tool fade out where it stopped rather than travel back to its start.
- Leave clear space between a symbol and the first inner detail in the large
  state, and move the first stop of the tool to match.

## Palettes
- Show WCAG contrast on each palette chip when the user wants impact.
- Light palettes need a flag: inverted and paper variants map roles differently,
  and the page around the tiles should stay dark.

## Headless Chrome verification
- `--virtual-time-budget` screenshots do not reliably show paused WAAPI states.
  Use `scripts/freeze-frame.py`: pause, copy computed styles inline (transform,
  opacity, stroke, fill), cancel, screenshot. Disable the page's resize listener
  in the copy.
- For final-state checks of CSS-animated tiles, inject
  `*{animation:none!important}` (`shot.sh --static`). Make the static state equal
  the final frame: use `animation-fill-mode: both` from a hidden 0% keyframe so
  un-played elements already look finished.
- `sips --cropOffset` takes `Y X` (row first).
- A bare SVG fills the Chrome window, so a 1024 window gives a 1024 PNG.

## Process
- Show 3 to 5 frames of any story animation; hand-off moments hide overlaps.
- When the user picks favourites, build mixes of those next.
- When the user rejects everything without a reason, ask before making more.
- Keep scratch files (static copies, frames, crops) in `.brand-tmp/` next to the
  page, not among the deliverables, and tell the user it exists.
- Some environments block shell commands containing deletes or writes outside the
  project; write scripts with the file tool and avoid `rm` in them.
