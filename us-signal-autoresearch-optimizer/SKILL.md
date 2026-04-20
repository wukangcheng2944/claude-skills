---
name: us-signal-autoresearch-optimizer
description: optimize the redfi us-signal prompt and evaluation workflow with an autoresearch-style loop. use when improving the us close to a-share signal agent, rewriting optimize-us-prompt.md, comparing prompt versions, or folding meeting notes and product-spec requirements into a repeatable test-evaluate-optimize cycle. prefer phase 1 nightly signal quality work, keep schemas and tool interfaces stable unless explicitly asked, and optimize for buy-side usefulness, mapping quality, timing notes, and confidence calibration.
---

# Us Signal Autoresearch Optimizer

把 prompt 优化当成“研究组织优化”，不是一次性改几句文案。默认优化对象是 RedFi 的 `us-signal` 夜间链路，而不是整个仓库。

## 默认边界

- 默认只优化 **phase 1 nightly flow**：`us close -> screen -> enrich -> map -> validate -> rank -> deliver`
- 会议里提到的“买方思维、前瞻性、主动推送、传播阶段、卖出信号”用于定义优化方向，但**不要默认扩成 phase 2/3 的全量能力建设**
- **不要把非公开、疑似合规风险的数据**当作当前版本的必要输入。把这类诉求改写成公开代理信号、领先媒体、X/Twitter、财报、公司 IR、概念板块、历史相关性或未来 backlog

## 先优化什么，不优化什么

### 默认允许修改的面

一次只动一个小面，并在每轮开始前写清楚本轮假设。

优先改这些位置：

- `system prompt` 里的信号分拣规则
- `system prompt` 里的 mapping / confidence / timing note 规则
- `optimize-us-prompt.md` 里的优化目标、接受标准、轮次设计
- 评估 rubric 与 spec gap 检查项
- 输出示例与 wording，使其更像 buy-side morning brief

### 默认不要动的面

除非用户明确要求，否则保持这些不变：

- 外部 `SignalReport` / JSON schema
- tool names / tool contract
- 数据库表结构
- Feishu 推送通道
- 产品 spec 里的核心阈值与 phase 划分
- 仓库里与 prompt 无关的代码逻辑

## 核心原则

1. **先有 baseline，再有 candidate**。没有基线就不要直接 auto-apply。
2. **一次只验证一个假设**。不要同时改 timing、mapping、schema wording、tool policy。
3. **窄动作空间**。像 `autoresearch` 只让 agent 动 `train.py` 一样，这里只让优化集中在 prompt / rubric / examples 的小范围。
4. **固定预算**。默认 3 轮；每轮都用相同的运行配方。
5. **固定评测集**。真实 trace 之外，必须同时看固定 canary cases。
6. **明确 accept / reject**。只保留真正提升主指标且不破坏 guardrail 的版本。
7. **把 prompt 当作研究组织的宪法**。优化的是“下一轮怎样更会研究”，不只是“这轮怎样更会说”。

## 默认主目标

默认主目标不是“解释更完整”，而是：

**next-day actionable signal quality**

也就是：第二天早上给用户看的简报，是否更像一个有买方思维的、可执行的、带时机判断的盘前信号，而不是卖方复盘。

## 硬 guardrails

任何一轮只要触发以下任一问题，直接判失败并回滚：

- schema 不合法或字段缺失
- bullish / bearish 路由错误（bearish 被写进正向 signals，或 bullish 被写进 risk_alerts）
- 把 bearish 输出写成 A 股做空建议，而不是持仓风险提醒
- 把 concept 映射与 supply chain 映射混为一谈
- 明显脱离 spec，随意改 benchmark、tier 或 phase 设定
- 把非公开信息写成既定事实

## 默认流程

### 静态重写场景

如果用户要你**直接重写 `optimize-us-prompt.md` 或优化技能文档**：

1. 先用 `references/domain-rubric.md` 定义这次优化的目标函数
2. 用 `references/golden-cases.md` 选择 3-5 个最相关 case 做手工 check
3. 重写文档，使其具备：
   - baseline / candidate / rollback 思维
   - 单假设迭代
   - phase 1 边界
   - buy-side / timing / mapping / confidence 评估
4. 输出：
   - 新版文档
   - 与旧版相比的关键升级点
   - 仍未解决的问题清单

### 真实循环场景

如果用户要你**真的跑 prompt 优化循环**：

1. 先读 `references/research-loop.md`
2. 锁定本轮单一假设与允许改动面
3. 备份当前 prompt / 相关文档或建立 git baseline
4. 跑 baseline
5. 生成 candidate 并 auto-apply
6. 跑 candidate 验证
7. 用 trace + canary cases 打分
8. accept 或 reject，并记录 lesson learned

## 每轮默认要回答的 5 个问题

每轮结束都要明确回答：

1. 本轮到底想提升什么？
2. 改动是否只发生在预定的小范围？
3. 主目标有没有提升？
4. 有没有伤到任何 hard guardrail？
5. 下一轮最值得试的唯一假设是什么？

## 输出格式

每轮都输出一段紧凑研究日志，至少包括：

- 当前 prompt 版本
- baseline 版本
- 单一假设
- 本轮改动面
- baseline vs candidate 结果
- spec gaps / regressions
- accept / reject
- 下一轮假设

## 领域判断口径

- 优先输出 **“今天该怎么看、该怎么分层、风险在哪里”**，而不是长篇解释昨晚发生了什么
- 重点增强这些维度：
  - `产业逻辑` vs `炒概念`
  - `first reaction` vs `already running`
  - `short-term` vs `mid-term`
  - `pullback opportunity` vs `thesis broken`
  - `verified / inferred / proposed / concept board`
  - `stock-specific alpha` vs `sector rotation`
- 对 Mag 7 触发，默认额外补一层 sector sentiment 视角
- 对 loser signal，默认降级成 **risk alert for holders**

## 参考文件

- `references/research-loop.md`：完整测试—评估—优化—回滚流程与命令配方
- `references/domain-rubric.md`：本项目里“更好”具体是什么意思
- `references/golden-cases.md`：固定 canary cases，防止 live trace 噪声把优化带偏
