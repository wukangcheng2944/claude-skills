---
name: icon-finder
description: Search and retrieve icons from major icon libraries (Lucide, Heroicons, Phosphor, Tabler, Remix Icon, Bootstrap Icons) via Iconify API. Triggers when user needs icons, asks for icon suggestions, or when building UI that requires icons. Returns SVG code, React/Vue components, or CDN links.
---

# Icon Finder

Search and retrieve icons from 6 major open-source icon libraries using the Iconify unified API.


## Agent-First Output Rule

This skill should narrow icon selection quickly. It should not stop at a broad list of icons without telling the next agent which library, icon id, and delivery format is the best fit for the project.

When returning icon results, make these explicit:
- `suspected_scope`: the most likely library, style family, and UI context
- `strongest_evidence`: the package already installed, the design constraints, or the best matching search result
- `next_best_action`: the single next selection or integration step
- `next_target`: the exact icon id, import path, SVG URL, or component snippet to use next
- `confidence`: high, medium, or low

## Supported Libraries

| Library | Iconify Prefix | Style | Best For |
|---------|---------------|-------|----------|
| Lucide | `lucide` | Line/stroke | React/Vue projects |
| Heroicons | `heroicons` | Outline + Solid | Tailwind projects |
| Phosphor Icons | `ph` | 6 weight variants | Design flexibility |
| Tabler Icons | `tabler` | Line/stroke, 5000+ | Large coverage |
| Remix Icon | `ri` | Line + Fill | Chinese ecosystem, commercial free |
| Bootstrap Icons | `bi` | Line + Fill | Simple projects, CDN |

## Workflow

### Step 1: Search Icons

Use WebFetch to query the Iconify search API (**use `api.simplesvg.com`**, the `api.iconify.design` domain returns 403):

```
https://api.simplesvg.com/search?query={keyword}&limit=24
```

To search within specific libraries only, add the `prefixes` param:

```
https://api.simplesvg.com/search?query={keyword}&prefixes=lucide,heroicons,tabler,ph,ri,bi&limit=32
```

Available prefixes: `lucide`, `heroicons`, `ph`, `tabler`, `ri`, `bi`

The response JSON has an `icons` array with strings like `"lucide:home"`, `"tabler:home"`.

### Step 2: Get SVG Code

Two methods available (both verified working):

#### Method A: Iconify API (recommended 鈥?works for ALL libraries)

```
https://api.simplesvg.com/{prefix}/{name}.svg
```

Examples:
- `https://api.simplesvg.com/lucide/home.svg`
- `https://api.simplesvg.com/tabler/arrow-right.svg`
- `https://api.simplesvg.com/ph/heart-fill.svg`
- `https://api.simplesvg.com/heroicons/home.svg`
- `https://api.simplesvg.com/ri/home-line.svg`
- `https://api.simplesvg.com/bi/house.svg`

Optional SVG params: `?width=24&height=24&color=%23333`

#### Method B: jsDelivr CDN (fallback 鈥?package-specific)

```
https://cdn.jsdelivr.net/npm/lucide-static@latest/icons/{name}.svg
https://cdn.jsdelivr.net/npm/@tabler/icons@latest/icons/outline/{name}.svg
https://cdn.jsdelivr.net/npm/@heroicons/react@latest/24/outline/esm/{Name}Icon.js
https://cdn.jsdelivr.net/npm/bootstrap-icons@latest/icons/{name}.svg
https://cdn.jsdelivr.net/npm/remixicon@latest/icons/{Category}/{name}.svg
```

### Step 3: Deliver to User

Based on the user's project context, provide the icon in the most useful format:

#### Raw SVG (universal)
Just output the SVG code from Step 2.

#### React Component (JSX)
```jsx
const HomeIcon = (props) => (
  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
    {/* paste path data from fetched SVG */}
  </svg>
);
```

#### Iconify Runtime (CDN 鈥?no build step needed)
```html
<script src="https://code.iconify.design/3/3.1.1/iconify.min.js"></script>
<span class="iconify" data-icon="lucide:home"></span>
```

#### Iconify React Component
```jsx
import { Icon } from '@iconify/react';
<Icon icon="lucide:home" width="24" />
```

#### Iconify Vue Component
```vue
<script setup>
import { Icon } from '@iconify/vue';
</script>
<template>
  <Icon icon="lucide:home" width="24" />
</template>
```

#### Native Library Import (if library is already installed in project)
```jsx
// Lucide React
import { Home } from 'lucide-react';
// Heroicons
import { HomeIcon } from '@heroicons/react/24/outline';
// Phosphor
import { House } from '@phosphor-icons/react';
// Tabler
import { IconHome } from '@tabler/icons-react';
// Remix Icon (CSS)
<i class="ri-home-line"></i>
// Bootstrap Icons
<i class="bi bi-house"></i>
```

## Advanced Search Patterns

### Search by category keywords
- UI controls: `arrow`, `chevron`, `menu`, `close`, `check`, `plus`, `minus`, `search`
- Social: `github`, `twitter`, `facebook`, `linkedin`, `instagram`
- Files: `file`, `folder`, `document`, `image`, `video`
- Communication: `mail`, `message`, `chat`, `phone`, `bell`
- Commerce: `cart`, `credit-card`, `dollar`, `tag`, `receipt`
- Media: `play`, `pause`, `volume`, `camera`, `mic`
- Navigation: `home`, `settings`, `user`, `star`, `heart`

### Multiple icons at once (batch fetch)
```
https://api.simplesvg.com/{prefix}.json?icons={name1},{name2},{name3}
```
Returns JSON with SVG body data for all requested icons in one call.

### Get collection info
```
https://api.simplesvg.com/collection?prefix={prefix}
```

## Best Practices

1. **Auto-detect project context**: Check package.json for existing icon libraries. If `lucide-react` is installed, prefer Lucide icons and use native imports.
2. **Suggest alternatives**: When showing search results, group by library so user can compare styles across libraries.
3. **Consistent style**: Within one project, recommend sticking to one icon library for visual consistency.
4. **Size and color**: Default to `width="24" height="24"`, use `currentColor` for stroke/fill so icons inherit text color via CSS.
5. **Accessibility**: Always add `aria-label="description"` for meaningful icons, or `aria-hidden="true"` for decorative ones.

## Fallback: Direct Library Websites

If Iconify API is unreachable, use WebSearch or browse library sites:

- Lucide: `https://lucide.dev/icons/{name}`
- Heroicons: `https://heroicons.com/`
- Phosphor: `https://phosphoricons.com/`
- Tabler: `https://tabler.io/icons?search={keyword}`
- Remix Icon: `https://remixicon.com/`
- Bootstrap Icons: `https://icons.getbootstrap.com/`
- Iconify browse: `https://icon-sets.iconify.design/?query={keyword}`
