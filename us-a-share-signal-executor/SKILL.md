---
name: us-a-share-signal-executor
description: execute the phase 1 redfi us-to-a-share nightly signal workflow. use when generating, revising, or reviewing the daily us close to a-share briefing, ranking cross-market signals, classifying supply-chain versus concept mappings, writing risk alerts for losers, or enforcing the phase 1 output format and tool-calling order. prefer the narrow production path from screen to enrich to map to validate to rank to deliver, keep phase 2 influencer research out unless the user explicitly asks, and optimize for actionable morning output rather than research-process commentary.
---

# Us A-Share Signal Executor

把它当成**生产执行 skill**：目标是稳定产出每天早上的 `US -> A股` 简报，不负责研究平台化优化。

## 默认边界

- 只服务 **phase 1 nightly flow**：`screen -> enrich -> map -> validate -> rank -> deliver`
- 默认场景是 **隔夜美股异动映射 A 股**，不是泛行业研究，也不是全量投顾
- 不默认展开 phase 2 influencer layer、专家网络、私有情报或大而全投研工作流
- 输出要像 **盘前 briefing**，不是长篇复盘，也不是 prompt 设计说明

## 主目标

每次执行都优先回答：

1. 昨晚哪只美股是真异动，不是指数噪声？
2. 这个异动更像 **产业链传导** 还是 **概念扩散**？
3. 对应 A 股标的里，哪些最值得排在前面？
4. 这是 **首次反应**、**加速扩散**，还是 **逻辑没坏的回调**？
5. 如果是下跌信号，应该如何写成 **持仓风险提醒**，而不是做空建议？

## 执行顺序

### 1. Screen

先做相对强弱筛选，而不是直接看绝对涨跌幅。

- 默认同时看 `NDX/QQQ` 和 sector ETF
- 先区分：
  - **stock-specific alpha**
  - **sector rotation**
- 对 Mag 7 触发，默认额外补一个 sector sentiment 视角

### 2. Enrich

确认美股为什么动。

- 先找可靠原因，再做映射
- 优先识别标准 move driver（必须用中文标签）：
  - 财报
  - 业绩指引
  - 产品发布
  - 需求变化
  - 利润率
  - 宏观
  - 并购重组
  - 其他
- 如果理由含混，不要假装知道；应降置信度或继续查
- **Exa 搜索策略**：映射覆盖 "thin"/"none" 时必须搜索；T1/T2 应搜索验证 driver
  - 英文查询验证供应链：`"{US_COMPANY} China supplier {PRODUCT}"`
  - 中文查询发现A股：`"{公司中文名} 供应商 A股"`
  - 搜索预算: T1=3次, T2=2次, T3=1次
  - 单一来源最高标注 "推断"，交叉验证(2+来源)才可标 "已验证"

### 3. Map

必须把映射拆成两条并行路径，绝不能混写：

- **supply chain**：更高置信度，偏基本面与订单传导
- **concept**：更快更短，偏叙事与情绪扩散

对每个候选都要明确：

- 映射类型
- 关系描述
- 为什么不是别的票排第一
- 是单票机会还是板块情绪机会

### 4. Validate

对每个映射给 provenance / confidence。

默认使用中文标签：

- `已验证`
- `推断`
- `提议`
- `概念板块`

规则：

- `已验证` 可直接作为主输出
- `推断` 可输出，但要写明推导基础
- `提议` 只能作为补充，不应压过高置信度映射
- `概念板块` 更适合概念链，不要冒充产业链证据

### 5. Rank

排序时不要只按“像不像相关概念”来排，优先综合：

- 异动强度
- move driver 对映射链条的穿透力
- 映射置信度
- 是否已被 A 股充分交易
- 当下所处阶段（信息扩散模型）：
  - 1.0 首次反应 — A股板块尚未反映
  - 1.5 早期扩散 — 机构开始关注，板块涨<5%
  - 2.0 加速扩散 — KOL讨论，板块涨5-10%
  - 2.5 已充分交易 — 券商研报/媒体报道
  - 3.0 主流共识 — 散户入场，考虑卖出
  - 逻辑未破的回调 — 回调但thesis完好

### 6. Deliver

输出紧凑、可执行、适合晨报。

每条 signal 默认包含：

- US stock / move summary
- move reason
- A 股目标（区分产业 / 概念）
- reasoning chain
- mapping confidence
- timing note
- action framing

## 强制规则

### 多头信号

- 优先讲 **为什么现在值得看**，不是把公开新闻复述一遍
- 先写高置信度产业链，再写概念扩散
- 如果更像 sector move，就不要硬装成单票 alpha

### 空头/下跌信号

- 默认写成 **risk alert for holders**
- 不输出 “建议做空 A 股某票” 这类表达
- 下跌概念传导天然更弱，默认降一档置信度

## timing note 口径

**必须先调用 `get_ashare_sector_trend(板块名, 60)` 获取实际板块走势数据，再写 timing_note。**

每次都尝试回答：

- 这是首次反应(1.0)，还是已经加速扩散(2.0+)？
- 这是逻辑强化，还是只剩媒体共识(3.0)？
- 昨天回调是不是买点（逻辑未破的回调），还是 thesis broken？

规则：
- 板块近60日涨>10% → 禁止写”首次反应”或”早期扩散”
- 板块近60日涨>20% → 必须标注”已充分交易(2.5)”或”主流共识(3.0)”
- 半导体/存储/AI算力等热门板块，默认不低于”加速扩散(2.0)”

不要把”价格下跌”自动等同于”逻辑破坏”。

## 供应链三重验证 (supply_chain_targets 专用)

加入 supply_chain_targets 前必须通过：
1. 这家A股公司是否**直接**向该美股公司销售/采购？
2. 能否说出具体交易内容（晶圆代工、封测、光学模组等）？
3. 收入依赖度大约多少？

**常见错误**：竞争者/同业/国产替代 ≠ supply chain → 必须放 concept_targets
- 中微公司 vs LRCX → concept（同赛道竞争者）
- 中芯国际 vs INTC → concept（全球同业）

## 默认输出结构

按以下顺序组织：

1. `Market Context`（中文市场摘要）
2. `Top Gainers -> A-share Opportunities`（signals 数组）
3. `Top Losers -> Risk Alerts`（risk_alerts 数组）
4. `Concept Watch`（仅在确有跨市场主题时）

单条 signal 的默认模板见 `references/output-template.md`。

## 失败条件

出现以下任一问题，视为执行失败：

- 把 supply chain 和 concept 写混
- 把 bearish 信号写成做空建议
- 没写 timing note
- 没给 mapping confidence
- 明显用新闻复述替代推理链
- 把 phase 2 influencer layer 当成默认必跑步骤

## 参考文件

- `references/phase1-rules.md`：phase 1 执行边界与判断细则
- `references/output-template.md`：晨报与单条 signal 模板
