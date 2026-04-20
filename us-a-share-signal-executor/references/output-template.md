# Output Template

## Daily briefing skeleton

### Market Context
- 1-2 sentence 中文市场摘要

### Top Gainers -> A-share Opportunities (signals 数组)
For each signal:
- **us_ticker / 涨跌幅**
- **move_driver** — `{category: "中文标签", details: "中文说明(限30字)"}` — category: 财报/产品发布/业绩指引/宏观/并购重组/需求变化/利润率/其他
- **supply_chain_targets** — 产业链标的 (confidence: 已验证/推断/提议)
- **concept_targets** — 概念标的 (confidence: 概念板块/推断/提议)
- **linkage_summary** — 2-3句中文关联逻辑(限50字)
- **confidence** — high/medium/low
- **timing_note** — 基于实际板块走势，使用阶段模型标签

### Top Losers -> Risk Alerts (risk_alerts 数组)
For each signal:
- **us_ticker / 跌幅**
- **move_driver** — 下跌原因
- **A-share exposure** — 相关产业链/概念标的
- **linkage_summary** — 持仓风险提醒表述
- **confidence** — 默认比同等bullish低一档

### Concept Watch
Only include when there is a real cross-market thematic wave.

## Per-signal wording template

### Bullish example
- **us_ticker:** NVDA beat both NDX and SMH on daily and weekly basis.
- **move_driver:** `{category: "业绩指引", details: "数据中心需求超预期，全年指引上调"}`
- **supply_chain_targets:** [产业链主票] first, confidence: 已验证
- **concept_targets:** [概念板块] second, confidence: 概念板块
- **linkage_summary:** "英伟达业绩指引上调确认AI算力需求持续，直接利好A股光模块和PCB供应商。"
- **confidence:** high
- **timing_note:** "加速扩散中(2.0)——AI算力板块近60日涨8%，机构已开始布局但尚有空间"

### Bearish example
- **us_ticker:** [ticker] materially underperformed benchmark.
- **move_driver:** `{category: "财报", details: "营收不及预期，下调全年指引"}`
- **linkage_summary:** "如果您持有 [A股标的] — [美股] 昨晚因 [原因] 相对下跌 [X]%。建议考虑降低风险敞口。"
- **confidence:** medium (bearish默认降一档)
- **timing_note:** based on actual sector data
