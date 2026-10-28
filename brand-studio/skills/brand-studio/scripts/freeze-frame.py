#!/usr/bin/env python3
"""Render one frame of a Web Animations API (element.animate) sequence for review.

Why: headless Chrome does not reliably capture paused WAAPI animations, and the
viewport resize during capture can fire the page's resize handler and snap the
animation to its end. This writes a copy of the page with a script that replays
the animation, pauses every animation at T ms, copies computed transform /
opacity / stroke into inline styles, cancels the animations, and leaves the
frozen frame on screen for the screenshot.

usage:
  freeze-frame.py <page.html> <out.html> <T_ms> <root_js> <selectors> [start_js]
    root_js    JS expression for an object whose ._a array holds the animations
               (a global array works too: "({_a: MY_ANIMS})")
    selectors  CSS selector list of every animated element
    start_js   optional JS that (re)starts the animation first
example:
  freeze-frame.py studio.html frame.html 2200 "stageStory" ".object,.symbol,.tool,.wordmark" "run(stageStory,true)"
  shot.sh frame.html frame.png 1280 700 5000
Remove or guard the page's resize listener before freezing (see references/lessons.md).
Run with: python3 -I freeze-frame.py ...
"""
import sys, re, os

src, out, t, root, sel = sys.argv[1:6]
start = sys.argv[6] if len(sys.argv) > 6 else ''
base = os.path.dirname(os.path.abspath(src))
s = open(src).read()
# make relative asset paths absolute so the copy can live anywhere
s = re.sub(r'(href|src)="(svg/|png/)', lambda m: f'{m.group(1)}="{base}/{m.group(2)}', s)
js = f"""<script>setTimeout(()=>{{{start};const st={root};const els=[...document.querySelectorAll('{sel}')];
(st._a||[]).forEach(a=>{{a.pause();a.currentTime={t}}});
const sn=els.map(e=>{{const c=getComputedStyle(e);return[e,c.transform,c.opacity,c.strokeDashoffset,c.stroke,c.fill]}});
(st._a||[]).forEach(a=>a.cancel());
sn.forEach(([e,tr,op,d,sk,fl])=>{{e.style.transform=tr;e.style.opacity=op;if(d)e.style.strokeDashoffset=d;if(e instanceof SVGElement){{e.style.stroke=sk;e.style.fill=fl}}}});
}},3000)</script></body>"""
open(out, 'w').write(s.replace('</body>', js, 1))
print(out)
