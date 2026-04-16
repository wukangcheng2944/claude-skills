---
name: icon-finder
description: "通过 Iconify API 搜索 6 大图标库(Lucide, Heroicons, Phosphor, Tabler, Remix Icon, Bootstrap Icons)。当用户说「找个图标」「icon for X」「需要图标」「搜索图标」「找一个xx图标」或在构建 UI 时需要图标时触发。返回 SVG/React/Vue 组件或 CDN 链接。"
---

# Icon Finder

Search and retrieve icons from 6 major open-source icon libraries using the Iconify unified API.

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

**⚠️ 空结果处理**：
- 如果 `icons` 数组为空或长度 < 3：
  1. 尝试同义词/近义词重新搜索（如 `shopping` → `cart`, `mail` → `envelope`）
  2. 去掉 `prefixes` 限制扩大搜索范围
  3. 如果仍无结果，告知用户"未找到匹配图标"并建议尝试其他关键词
- 如果 API 返回错误/超时 → 使用 Fallback 方案（见底部）

### Step 1.5: 项目上下文检测 & 用户确认检查点

在获取 SVG 之前，先检测项目环境并**暂停等待用户选择**：

```
1. 检查当前项目的 package.json / requirements.txt：
   - 已安装 lucide-react → 优先推荐 Lucide 图标 + native import
   - 已安装 @heroicons/react → 优先推荐 Heroicons + native import
   - 已安装 @tabler/icons-react → 优先推荐 Tabler + native import
   - 未安装任何图标库 → 推荐 Iconify Runtime 或 raw SVG
   - ⚠️ 检测失败(无 package.json) → 默认全库搜索 + raw SVG 输出

2. ⏸️ 【用户确认检查点】展示搜索结果，按库分组：
   "找到 N 个图标，推荐使用 [检测到的库]：
    ✦ Lucide: shopping-cart, shopping-bag
    ✦ Heroicons: shopping-cart
    ✦ Tabler: shopping-cart, basket
    请选择图标，或输入其他关键词重新搜索。"

3. 用户选择后 → 进入 Step 2 获取 SVG
   用户要求重搜 → 回到 Step 1 换关键词
```

### Step 2: Get SVG Code

Two methods available (both verified working):

#### Method A: Iconify API (recommended — works for ALL libraries)

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

#### Method B: jsDelivr CDN (fallback — package-specific)

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

#### Iconify Runtime (CDN — no build step needed)
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
