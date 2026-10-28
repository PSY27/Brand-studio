---
description: Screenshot-check a brand HTML page (final states, details and animation frames) and fix what's wrong
argument-hint: "<path to the HTML page>"
---

Verify the brand page at: $ARGUMENTS

Using the `brand-studio` skill's scripts:
1. `shot.sh <page> <out.png> 1280 1600 6000 --static` and look at the result.
2. Crop and zoom every logo, icon and lockup with `crop.sh` (check symbols in letter slots, overlaps, handles touching letters, small-size previews).
3. If the page has a Web Animations API sequence, capture 3 to 5 frames with `freeze-frame.py`, focusing on hand-off moments.
4. Fix what is wrong, re-check, and report what you fixed and anything you could not verify.

Keep scratch files in `.brand-tmp/` next to the page.
