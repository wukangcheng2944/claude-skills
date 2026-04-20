---
name: us-a-share-signal-optimizer
description: optimize the redfi us-to-a-share signal agent with a narrow, autoresearch-style evaluation loop. use when improving prompt files, rewriting optimization docs, comparing baseline versus candidate versions, turning meeting notes into scoring rules, or deciding whether a change to the phase 1 us-to-a-share workflow should be accepted, rejected, or rolled back. prefer single-hypothesis iterations, fixed canary cases, and phase 1 signal quality over broad product redesign.
---

# Us A-Share Signal Optimizer

把它当成**研究优化 skill**：不直接替代生产输出，而是持续改进生产 skill 的判断质量。

## 这个 skill 专门做什么

它负责把“会议里的投资洞察”和“产品 spec 的硬约束”变成一套可反复执行的优化闭环。

默认优化对象：

- `system prompt`
- `optimize-us-prompt.md`
- 输出样例
- 评估 rubric
- mapping / timing / confidence 规则
- Exa search strategy section（搜索查询模板、搜索预算、结果验证规则）

默认**不**直接改：

- 数据库 schema
- tool names / tool contract
- Feishu 推送链路
- phase 划分
- 与 prompt 无关的代码逻辑

## 核心原则

1. **先 baseline，后 candidate**
2. **一次只改一个假设**
3. **固定 canary cases**，不要只信 live trace
4. **主目标单一**：提升 next-day actionable signal quality
5. **任何触发 hard guardrail 的版本直接 reject**
6. **留下研究日志**，不要只留下“最新 prompt”

## 默认优化目标

不是把回答写得更长，而是让 signal 更像一个真的买方早会助手。

重点优化这些维度：

- buy-side usefulness
- mapping quality
- timing / stage judgment
- confidence calibration
- loser-as-risk-alert framing
- phase 1 scope discipline
- search quality（搜索查询质量、搜索结果与信号质量的关联性）

## 默认流程

### 1. 定义本轮唯一假设

每轮只能有一个主要假设，例如：

- timing note 太泛，需要更强的阶段判断
- concept / supply chain 经常混写，需要更强分层
- bearish 输出不够像 risk alert，需要重写负向 framing
- Mag 7 触发后缺少 sector sentiment 说明

不要一轮里同时改 4 件事。

### 2. 锁定允许改动面

本轮只允许动一个小面，例如：

- system prompt 某一段
- 输出 template
- rubric 某一维
- 几条 few-shot 示例

### 3. 跑 baseline

先记录现状：

- 当前版本号
- 当前 prompt / doc
- 现有已知问题
- baseline 在固定 case 上的表现

### 4. 生成 candidate

candidate 只解决本轮那个单一假设。

要求：

- 不破坏 schema 与路由
- 不引入 phase 2 的默认复杂度
- 不把“更前瞻”写成“更会猜”

### 5. 评估

同时看：

- live trace
- 固定 canary cases
- spec gap 检查
- hard guardrails

### 6. Accept / Reject

- **Accept**：主目标明确提升，且没有新回归
- **Reject**：无提升、提升不稳定、或伤到 guardrails
- **Rollback**：candidate 破坏生产可靠性时立刻回滚

## hard guardrails

任一触发即 reject：

- schema 不合法
- bullish / bearish 路由错
- bearish 被写成做空建议
- supply chain / concept 混写
- 随意越过 phase 1 范围
- 把非公开或不可验证信息写成事实

## 如何吸收会议纪要里的洞察

允许吸收这些方向：

- 买方思维
- 主动推送意识
- 前瞻性与阶段判断
- “看见所以相信” vs “因为相信所以看见”的差异
- 主流媒体扩散后要降级看待
- 回调与 thesis broken 要区分

但要做两件事：

1. 把它们**转成可评估规则**
2. 不把专家网络、灰色私有信息、合规风险渠道写成当前版本默认依赖

## 默认输出

每轮优化都输出一段研究日志，至少包含：

- baseline version
- candidate version
- single hypothesis
- changed surface
- baseline vs candidate result
- regressions
- accept / reject
- next hypothesis

## 工作方法

- 先读 `references/domain-rubric.md`
- 再读 `references/golden-cases.md`
- 真跑循环时按 `references/research-loop.md`

## 这个 skill 与执行 skill 的关系

- `us-a-share-signal-executor` 负责每天产出
- 本 skill 负责改进它

不要把两者写成一个大而全的技能；默认先保生产，再做研究。
