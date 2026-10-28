---
name: brand-studio
description: Build a product or company brand identity end to end as interactive HTML - name and domain check, wordmark and logo explorations, an animated "story" logo, a logo studio with font / colour / palette controls, symbol, monogram and app-icon explorations, icon motion, favicon and icon exports, and a brand kit page. Use when the user asks for a logo, logo animation, brand kit, app icon, favicon, monogram, logo variations, brand colours or fonts, or says "make a brand / identity / logo studio".
---

# Brand Studio

Turn a product idea into a working, animated identity the user can click through
in a browser. Everything is single-file HTML (no build step), checked with
headless-Chrome screenshots before it is shown to the user.

## Vocabulary used in this skill

- **Wordmark**: the brand name set in type.
- **Letter slot**: a part of a letter that can hold a symbol (an i or j dot, a
  counter such as the hole in b / o / B, the top of a tall stem).
- **Symbol**: a small meaningful mark placed in a letter slot or used alone.
- **Object**: the thing the product deals with (a document, a card, a parcel...).
- **Tool**: the thing that acts on the object (a lens, a pen, a scanner...).
- **Container**: a solid shape with a symbol knocked out of it (as in many app icons).
- **Accent**: the one colour reserved for the "found it / key moment" detail.

## Templates (worked examples, adapt them)

The files in `templates/` come from a real project, so they contain that
project's name, symbols and colours. Treat them as structure and code to reuse:
read the one you need, keep the mechanics (layout, controls, measuring, motion,
preview sizes) and replace the brand-specific content.

| Template | Mechanics it demonstrates | Reuse for |
|---|---|---|
| `templates/landing-and-logo-lab.html` | Bold-minimal landing page; logo lab with a stage, background / accent controls, many animated options, "Use on page" | First direction pass |
| `templates/logo-studio.html` | Story logo; 20 variable fonts with weight slider; split colouring of the wordmark halves; palettes; presets; canvas measurement of letter slots (`measure()`) | Final logo tuning |
| `templates/brand-kit.html` | Hero logo motion, animated app icons, phone / chat-app / browser-tab previews, loader, motion + colour spec, export list | Hand-off page |
| `templates/symbol-marks.html` | Grid of symbol-only marks with app icon + 48 / 32 / 16 px previews and a colour toggle | Symbol exploration |
| `templates/wordmark-marks.html` | Word + symbol lockups placed from measured glyph metrics, wide + square previews | Lockups |
| `templates/icon-palette-motion.html` | Container icon with a knocked-out symbol in several variants; palette chips with role mapping ranked by WCAG contrast; "open, work, close" icon animation; pattern banners | Icon from a reference image, palette comparison, icon motion |

## Scripts (`scripts/`, run from anywhere)

- `shot.sh <page> <out.png> [w] [h] [budget] [--static]` screenshot; `--static` disables CSS animations so you see final states (copy goes in `.brand-tmp/`).
- `crop.sh <in> <out> x y w h [scale]` zoom into a detail.
- `freeze-frame.py` capture a mid-animation frame of a Web Animations API sequence (see its header).
- `export-icons.sh <icon.svg> <outdir> [name]` 1024 / 512 / 192 PNGs; name `favicon` also makes 32, 16 and apple-touch 180.
- `check-domains.sh a.com a.io ...` RDAP lookup when `whois` is blocked.

## Workflow

Go one step at a time and show each result; expect frequent redirection.

1. **Name.** Brainstorm names that suit the logo idea (if the idea uses letter
   slots, names with the right letters help), check domains with
   `check-domains.sh` (sanity-check a known domain first), flag trademark risk when
   key TLDs were registered recently, and recommend one.
2. **Direction.** Offer 3 to 4 visual directions (for example bold minimal, warm
   human, dark premium, local and trustworthy) with previews. Build the chosen one
   as a landing page with the logo in the nav and a brand section at the bottom.
3. **Logo lab.** Many animated options in a grid plus a large stage. Hover plays,
   click loads into the stage, controls switch background and accent, "Use on
   page" puts it in the nav. When the user picks favourites, make *mixes* of them
   rather than more unrelated options.
4. **Story logo.** When motion should mean something, choreograph it (see
   `references/design-patterns.md`): the object appears, the tool examines it,
   the key moment lights up in the accent, parts fly and land in letter slots,
   the wordmark reveals.
5. **Logo studio.** Fonts (variable families with a weight slider), how to colour
   each part of the wordmark, palettes, presets. Keep what the user has locked in
   as the default.
6. **Identifier (symbol / monogram / app icon).** Explore it separately from the
   wordmark. Always show 48, 32 and 16 px previews: uniqueness only counts if it
   reads tiny. Cover several families (symbols alone, symbol in container, letter
   monograms, word + symbol lockups, object + tool scenes).
7. **Icon motion.** If wanted, animate the icon opening into the full scene and
   closing back (see design patterns).
8. **Brand kit.** One page: logo motion, app icons, in-context previews, loader,
   motion + colour spec, files. Export icons with `export-icons.sh`.

## Handling feedback

- **"I don't like it" with no reason:** ask which part (logo, look, layout, copy)
  and which direction, with visual options, before making more.
- **A pasted reference image:** copy its construction exactly (shape language,
  fill vs outline, proportions), put the user's symbol in it, and show one variant
  in the reference's own colour layout before switching to the brand palette.
- **Colour complaints:** do not guess a single new palette. Add a palette row of
  10 to 14 chips that recolours everything live. Define palettes by role
  (background, main shape, symbol, accent, paper) and map roles per variant, so one
  palette works for normal, inverted and paper versions. If the user names a hue
  family or asks for "high visual difference", restrict to that family and show
  each chip's WCAG contrast, highest first.
- **Ambiguous words:** confirm what a word refers to (the word itself, a drawing
  of the thing, a letter) before building a batch.
- **"Only X":** take it literally and remove everything else.

## Rules

- **Verify every page before presenting it.** Screenshot with `shot.sh --static`,
  crop and zoom the details (slots, overlaps, handles touching letters). For
  animation, check 3 to 5 frames with `freeze-frame.py`, especially hand-off
  moments. Fix and re-check; tell the user what you fixed and what you could not verify.
- **Place symbols from measured glyphs, not guessed em offsets.** Rasterise the
  glyph on a canvas and scan pixels for dot, stem centre, x-height and counters.
  Guessed offsets break as soon as the font changes.
- **Size symbols relative to the font's own slot.** A symbol replacing a letter
  dot should be roughly 1.1x to 1.3x the measured dot height, or it touches the
  letter below.
- **Keep exports full-bleed squares**; iOS and Android apply their own masks.
- **Check symbol legality and conventions**, for example avoid a red cross / plus
  on white (protected emblem) and currency or flag misuse.
- Respect `prefers-reduced-motion`: show the final frame only.
- Follow the user's writing rules in all copy.
- Read `references/lessons.md` before writing animation or measurement code.

## Deliverables checklist

- [ ] Landing / brand page with the logo in context
- [ ] Logo lab or studio with the user's locked choices as defaults
- [ ] Animated logo plus a static final frame
- [ ] App icon(s) with 48 / 32 / 16 px previews, exported PNGs
- [ ] Favicon SVG + 32 / 16 / apple-touch PNGs
- [ ] Brand kit page: colours (hex), type, motion timings, do and don't
- [ ] A short note of what is not finished (for example wordmark not outlined for print)
