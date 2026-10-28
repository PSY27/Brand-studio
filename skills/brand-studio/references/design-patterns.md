# Design patterns that work

## Letter-slot marks
Replace parts of letters with meaningful symbols, placed from measured glyphs:
- Dots of i / j become symbols. Two dotted letters give two slots, so a name with
  two of them can tell a two-part story (for example "what" + "how").
- Counters (the holes in b, d, o, B) can hold a symbol.
- A tall stem can wear a symbol like a dot.
- In a compound name, colour the second half in the symbol's colour so symbol and
  word read together; keep the first half neutral.

## Story logo choreography (about 4 to 5 s, plays once)
1. The object appears (draws itself or scales in).
2. The tool examines it (glides across, overshoots, comes back).
3. The key moment lights up in the accent.
4. A part of the object detaches and flies in an arc to its letter slot, spinning
   about its own centre, landing with an overshoot (about 1.25x, 0.88x, 1.04x, 1).
5. The object fades and shrinks *before* the wordmark rises in, so they never overlap.
6. The tool flies *above* the wordmark, not through it, and lands a beat after
   the first part so the two landings do not collide.
The final frame equals the static logo.

## Identifier families to explore
Show each at app-icon size plus 48, 32 and 16 px:
- Symbols alone (for example the two slot symbols as a pair, stacked, diagonal).
- Symbol inside the tool, magnified (thicker inside the glass / frame).
- Symbol as a detail of the tool (a glint, a handle, a badge).
- The object *is* the tool (object-shaped frame with a handle).
- Container icon: a solid shape with the object or symbol knocked out.
- Letter monograms built from the real font (a letter with its slot symbol, a
  letter with a symbol in its counter, two-letter pairs).
- Word + symbol lockups (part of the name as text, the rest as a symbol).
Small-size winners are usually the simplest silhouettes; derive a simplified
favicon from the main icon if it has text or fine detail.

## Container icon with a knocked-out scene
A solid shape (circle, rounded square, tool silhouette) with the object cut out
of it, and a small symbol on the object, reads from 1024 down to 16 px. Variants
worth showing: cut-out object, inverted colours, light "paper" object, no inner
detail (best favicon), one detail in the accent (the key moment), slightly tilted
object. Pair it with a pattern banner: the icon in the centre, faded copies tiled around.

## Icon motion: open, work, close (about 5.5 s)
1. 0 to 1.25 s: the object grows out of the icon into a large version while the
   solid container shrinks away to one side.
2. 1.25 to 3 s: an outline version of the tool works on the large object,
   overshoots, returns and stops; the key detail lights up in the accent.
3. 3.5 to 4.6 s: the container grows back behind the object, the object's colours
   revert, it shrinks back in, and the icon settles with a small overshoot.

## Palettes
Dark background, a neutral for the first part of the wordmark, one symbol colour,
one accent for the key moment. Keep 6 to 14 named palettes as chips, each defined
by roles (background, main shape, symbol, accent, paper, light flag). Rank chips by
WCAG contrast between background and main shape when the user cares about impact
(black + lime is about 17:1, neon green on black about 15:1).

## Fonts that suit bold-minimal wordmarks
Space Grotesk, Inter Tight, Sora, Plus Jakarta Sans, Outfit, Bricolage Grotesque,
Manrope, DM Sans, Figtree, Onest, Unbounded, Schibsted Grotesk, Archivo, Urbanist.
Prefer variable families so a weight slider works.
