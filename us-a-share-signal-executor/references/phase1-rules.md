# Phase 1 Rules

## 1. Keep the product narrow

This skill is for the nightly US-to-A-share signal path only:

`US Close -> Screen -> Enrich -> Map -> Validate -> Rank -> Deliver`

Do not expand into influencer monitoring, portfolio personalization, or closed-loop threshold tuning unless explicitly asked.

## 2. Dual-benchmark interpretation

Use the broad benchmark (NDX/^NDX) and sector benchmark together.

- Beats both broad index and sector ETF -> strongest stock-specific signal
- Beats broad index but not sector ETF -> more likely sector rotation
- Mega-caps may need extra caution because of self-reference effects

## 3. Mapping logic

### Supply chain (supply_chain_targets)

Use when there is concrete transmission logic such as:

- order growth
- new product production run
- customer dependence
- direct supplier relationship

**三重验证**: 必须能说出具体交易内容和收入依赖度。"同业"/"对标"/"竞争者"/"国产替代" = NOT supply chain。

### Concept (concept_targets)

Use when the transmission is mainly narrative-driven:

- AI heat
- theme board rotation
- retail concept follow-through
- symbolic association rather than revenue pass-through
- 竞争者/同赛道/国产替代

Do not present concept mappings as if they were verified revenue links.

## 4. Confidence ladder (中文标签)

- **已验证**: manually validated or directly supported by filings / disclosed customer evidence
- **推断**: derived from company descriptions, revenue mix, or strong indirect evidence
- **提议**: fresh candidate found in real-time discovery; suitable as a supplementary idea
- **概念板块**: board-sourced thematic linkage; useful for concept trade framing

## 5. Timing interpretation (信息扩散阶段模型)

**必须先调用 `get_ashare_sector_trend(板块名, 60)` 获取60日板块走势数据。**

| 阶段 | 特征 | timing_note 标签 |
|------|------|-----------------|
| 1.0 | 产业链内部/先知先觉资金，A股板块尚未启动 | 首次反应 |
| 1.5 | 机构/聪明资金介入，板块微涨(<5%) | 早期扩散 |
| 2.0 | 大V/KOL讨论，板块已涨5-10% | 加速扩散中 |
| 2.5 | 券商研报推荐，财经媒体报道 | 已充分交易 |
| 3.0 | 财联社/华尔街见闻广泛报道，散户入场 | 主流共识已形成 |
| 回调 | 逻辑未破但价格回调 | 逻辑未破的回调 |

Rules:
- 板块近60日涨>10% → 禁止"首次反应"或"早期扩散"
- 板块近60日涨>20% → 必须"已充分交易"或"主流共识已形成"
- 半导体/存储/AI算力等热门板块，默认不低于"加速扩散中(2.0)"

Avoid vague timing language like "值得关注" unless you explain *why now*.

## 6. Loser handling

The default framing for negative signals is risk management for holders.

Use language like:

- 如果您持有 [A股标的] — [美股] 昨晚因 [原因] 相对下跌 [X]%
- 建议考虑降低风险敞口
- 下跌概念传导比上涨更弱，默认降一档置信度

Do not write the signal as an A-share short recommendation.
