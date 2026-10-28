# Install

## Claude Code (plugin)

Send these as two separate prompts:

```
/plugin marketplace add YOUR_GITHUB_USER/brand-studio
```
```
/plugin install brand-studio@brand-studio
```

The skill loads automatically when you ask for a logo, logo animation, brand kit, app icon, favicon, monogram, logo variations, or brand colours or fonts. You can also run `/brand-studio <idea>`.

## Claude Code (skill only, no plugin)

Copy the skill folder into your personal skills:

```bash
git clone https://github.com/YOUR_GITHUB_USER/brand-studio
cp -R brand-studio/skills/brand-studio ~/.claude/skills/
```

## Other agents (Cursor, Codex, Copilot, Windsurf, and so on)

Most agents read `AGENTS.md`. Copy it into your project root together with `skills/brand-studio/` (the scripts, references and templates it points to):

```bash
cp brand-studio/AGENTS.md your-project/
cp -R brand-studio/skills your-project/
```

Cursor users can also copy `.cursor/rules/brand-studio.mdc` into their project's `.cursor/rules/`.

## Requirements

- **Google Chrome**, for screenshots and icon exports. The scripts look for it at the default macOS path, then `google-chrome` / `chromium` on PATH.
- **Python 3**, for `freeze-frame.py` and domain checks.
- **macOS `sips`**, for crops and resizing. On Linux, replace it with ImageMagick (`convert -crop`, `convert -resize`) in `crop.sh` and `export-icons.sh`.
- **Internet**, for Google Fonts and domain lookups.

Make the scripts executable after cloning if needed:

```bash
chmod +x skills/brand-studio/scripts/shot.sh skills/brand-studio/scripts/crop.sh skills/brand-studio/scripts/export-icons.sh skills/brand-studio/scripts/check-domains.sh
```
