# Domain Rubric

Use this rubric to judge whether a prompt change is actually better.

## 1. Buy-side usefulness

Ask:

- Does the output help a PM or trader decide what deserves attention before the open?
- Does it prioritize what matters now rather than merely explain what happened?
- Does it avoid sell-side recap language?

## 2. Mapping quality

Ask:

- Are supply-chain and concept paths clearly separated?
- Is the top-ranked A-share target actually the best transmission candidate?
- Is the relationship explained with a concrete chain, not just a label match?

## 3. Timing / stage judgment

Ask:

- Does the signal tell us the current diffusion stage (首次反应/早期扩散/加速扩散/已充分交易/主流共识/逻辑未破的回调)?
- Was `get_ashare_sector_trend` called before writing timing_note?
- Does it distinguish pullback opportunity (逻辑未破的回调) from thesis broken?
- Does it avoid chasing obvious, fully-diffused stories (板块涨>10% should not be "首次反应")?

## 4. Confidence calibration

Ask:

- Does the output use 已验证 / 推断 / 提议 / 概念板块 (Chinese labels) appropriately?
- Are weak concept links prevented from overpowering strong supply-chain evidence?
- Are loser concept links downgraded appropriately?
- Are move_driver categories using Chinese labels (财报/产品发布/业绩指引/宏观/并购重组/需求变化/利润率/其他)?

## 5. Production reliability

Ask:

- Is the schema still valid?
- Is bullish routed to opportunities and bearish routed to risk alerts?
- Does the output remain concise enough for a morning briefing?
