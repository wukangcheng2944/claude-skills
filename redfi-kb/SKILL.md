---
name: redfi-kb
description: RedFi 生态知识库读写技能。当用户提到以下 9 个项目中的任何一个 (data_monitor, data_platform, finder-catch, l2t, icon, ma_club, redfi-autoresearch, redfi-claw, redfi-invest-agent)，或问跨项目关系/数据流/集成/共享基建/业务域/可复用模块，或说「更新 vault」「更新认知」「重新扫描 xx」「RedFi 生态」「知识库」时自动加载。Vault 在 D:\workspace\knowledge-base\。
---

# RedFi 生态知识库技能

Obsidian vault 位置：`D:\workspace\knowledge-base\`

## 何时使用

- 用户提到 9 个项目之一：`data_monitor` `data_platform` `finder-catch` `l2t` `icon` `ma_club` `redfi-autoresearch` `redfi-claw` `redfi-invest-agent`
- 用户问项目间的关系、数据流、API 集成、共享基建、业务域划分、可复用模块
- 用户说「更新 vault」「更新 xx 认知」「重新扫描 xx」「给 vault 加 xx」
- 用户问「RedFi 生态怎么组织」「这几个项目什么关系」等架构问题

## Vault 结构

```
D:\workspace\knowledge-base\
├── README.md                          # 总索引 MOC，速览表
├── projects\
│   ├── data_monitor.md                # 深度档案（frontmatter + 定位/技术栈/架构/数据流/依赖/部署/siblings/复用/关键文件）
│   ├── data_platform.md
│   ├── finder-catch.md
│   ├── l2t.md
│   ├── icon.md
│   ├── ma_club.md
│   ├── redfi-autoresearch.md
│   ├── redfi-claw.md
│   └── redfi-invest-agent.md
├── relationships\
│   ├── ecosystem-map.md               # Mermaid 总图 + 耦合强度
│   ├── data-flow.md                   # 6 个端到端数据流场景
│   ├── api-integrations.md            # 带文件证据的 API 调用清单
│   ├── shared-infrastructure.md       # 域名/飞书/阿里云/PG/Redis/LLM
│   └── reusable-modules.md            # P0-P2 抽取候选
└── domains\
    ├── content-pipeline.md            # finder-catch → l2t → autoresearch → redfi-claw
    ├── investment-research.md         # redfi-invest-agent → ma_club
    ├── data-collection.md             # data_monitor / data_platform / finder-catch
    └── shared-assets.md               # icon
```

## 读取流程（用户提问时）

1. **默认先读** `D:\workspace\knowledge-base\README.md` 获取全局索引（除非上下文已有）。
2. 根据问题类型按需读取：
   - 单项目问题 → `projects\<name>.md`
   - 跨项目关系 → `relationships\ecosystem-map.md` + `api-integrations.md`
   - 业务域问题 → `domains\<domain>.md`
   - 复用重构问题 → `relationships\reusable-modules.md`
3. ⚠️ **验证时效性**：vault 是扫描快照，如果用户要基于某条信息采取行动（修改代码、发 PR、部署），**先用 Read/Grep 验证当前仓库状态**再声称事实。快照里的函数名/端口/file:line 可能已变。
4. 回答时用 wiki-link 风格引用 `[[projects/xxx]]` 但给用户显示的路径用绝对路径 `D:\workspace\knowledge-base\projects\xxx.md` 方便打开。

## 更新流程（用户说"更新 xx"时）

### 单项目更新

用户说「更新 finder-catch 的认知」或类似：

1. 派一个 `Explore` subagent（`subagent_type: Explore`, `thoroughness: very thorough`）深度重扫该项目
2. 提示词模板（复用首次扫描时的结构）：
   ```
   Deeply re-analyze D:\workspace\<project>. Context: updating existing knowledge vault entry.
   Produce markdown with these sections and nothing else:
   ## Purpose & Business Domain
   ## Tech Stack
   ## Architecture & Entry Points
   ## Data Flow (IN/OUT)
   ## External Dependencies
   ## Deployment & Runtime
   ## Potential Links to Siblings (quote file:line evidence; siblings are: [其余 8 个])
   ## Reusable / Shared Modules
   ## Notable Files to Remember
   Be factual. Say "not found" rather than guessing. Cite with forward slashes. ~800 words.
   ```
3. 拿到结果后：
   - Read 当前 `projects\<name>.md`
   - **Diff 对比**，列出有实质性变化的条目（新依赖、端口变化、新 sibling 集成、架构重构等）
   - 给用户展示 diff 摘要让其确认
   - 用 Edit/Write 更新该 md（保留 frontmatter，更新 `last-scanned` 为今天日期）
   - 如果发现新的跨项目集成，**同步更新** `relationships\api-integrations.md` + `ecosystem-map.md`

### 全量更新

用户说「重扫所有」「更新整个 vault」：

1. 并行派 9 个 Explore agent（在一条消息里多个 tool call）
2. 按上述流程逐项目 diff + Edit
3. 重写 `relationships\*` 根据新发现
4. 更新 `README.md` 的 last updated 日期

### 添加新项目

用户说「把 xxx 项目也加进 vault」：

1. Explore agent 深度扫 xxx
2. 新建 `projects\xxx.md`，按现有模板结构填写
3. 判断归属哪个 domain，更新 `domains\<dom>.md`
4. 如果和现有项目有集成，更新 `relationships\api-integrations.md` + `ecosystem-map.md`
5. 在 `README.md` 的速览表加一行
6. 更新此 SKILL.md 的 description 加上新项目名

### 删除项目

用户说「xxx 项目已废弃，从 vault 删掉」：

1. 删 `projects\xxx.md`
2. 从 `README.md` 速览表、`ecosystem-map.md` Mermaid、`api-integrations.md`、对应 domain 文件里移除相关引用
3. 更新此 SKILL.md description

## 关键速查（缓存常用事实）

- **强耦合对**：finder-catch→l2t（直接 import）、redfi-autoresearch→4 siblings（ServiceConnector）、ma_club→redfi-invest-agent（Hot Topics API）
- **飞书中枢**：redfi-claw
- **内容编排器**：redfi-autoresearch
- **投研编排器**：ma_club（消费 redfi-invest-agent）
- **孤岛**：icon（无代码引用）
- **分叉**：finder-catch 用 WeCom 而非 Lark 飞书
- **生产域名**：`hot.redfiai.com`（多项目共享）、`hot.redfi.top`（ma_club AWS）
- **部署据点**：ALi3（legacy 多项目）、AWS（ma_club 主）

## 反模式

- ❌ 不要把完整的 vault 内容塞进上下文 — 按需读取
- ❌ 不要基于 vault 里的 file:line 引用直接修改代码 — 先验证
- ❌ 不要在用户没说更新时主动更新 vault — 除非发现明显矛盾
- ❌ 不要在更新时无脑覆盖 — 要先 diff + 告知用户有哪些变化
- ❌ 不要删除 frontmatter（`project`/`path`/`domain`/`status`/`last-scanned` 字段）
