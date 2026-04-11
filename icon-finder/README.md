# icon-finder

A Claude Code skill that searches and retrieves icons from 6 major open-source icon libraries via the [Iconify](https://iconify.design) unified API.

## Supported Libraries

| Library | Prefix | Icons | License |
|---------|--------|-------|---------|
| [Lucide](https://lucide.dev) | `lucide` | 1500+ | ISC |
| [Heroicons](https://heroicons.com) | `heroicons` | 300+ | MIT |
| [Phosphor Icons](https://phosphoricons.com) | `ph` | 9000+ | MIT |
| [Tabler Icons](https://tabler.io/icons) | `tabler` | 5000+ | MIT |
| [Remix Icon](https://remixicon.com) | `ri` | 2800+ | Apache 2.0 |
| [Bootstrap Icons](https://icons.getbootstrap.com) | `bi` | 2000+ | MIT |

## Installation

Copy the `icon-finder` folder into your Claude Code skills directory:

```bash
cp -r icon-finder ~/.claude/skills/
```

Or clone this repo directly:

```bash
git clone https://github.com/wukangcheng2944/claude-skill-icon-finder.git ~/.claude/skills/icon-finder
```

## How It Works

1. **Search** — Queries `api.simplesvg.com` (Iconify) to find matching icons across all 6 libraries
2. **Fetch SVG** — Retrieves the actual SVG code for selected icons
3. **Deliver** — Outputs in the format best suited for your project (raw SVG, React/Vue component, Iconify runtime, or native library import)

## Usage in Claude Code

The skill triggers automatically when you ask for icons:

- "Find me a shopping cart icon"
- "I need social media icons as SVGs"
- "Get a settings gear icon for my React project"

Or invoke manually with `/icon-finder`.

## Output Formats

- **Raw SVG** — Universal, copy-paste anywhere
- **React JSX Component** — Inline SVG wrapped as a component
- **Vue SFC** — Single File Component with SVG
- **Iconify React/Vue** — `<Icon icon="lucide:home" />` with `@iconify/react` or `@iconify/vue`
- **Native Import** — `import { Home } from 'lucide-react'` (when library is already installed)
- **CDN Runtime** — Zero-build Iconify script tag

## API Endpoints Used

| Purpose | URL |
|---------|-----|
| Search | `https://api.simplesvg.com/search?query={keyword}&prefixes=lucide,heroicons,tabler,ph,ri,bi` |
| Get SVG | `https://api.simplesvg.com/{prefix}/{name}.svg` |
| Batch | `https://api.simplesvg.com/{prefix}.json?icons={name1},{name2}` |
| Fallback | `https://cdn.jsdelivr.net/npm/lucide-static@latest/icons/{name}.svg` |

## License

MIT
