# Domain rubric

本项目里“更好”不是更会复盘，而是更会做 **美股收盘后到 A 股开盘前** 的盘前研究组织。

## 一、主目标

主目标：**next-day actionable signal quality**

一个更好的版本，应该更像买方盘前简报：

- 给出今天能不能用
- 为什么能用
- 属于哪条线
- 处在传播的哪个阶段
- 风险在哪里
- 该当成短线、波段还是持仓风险提醒

## 二、硬 guardrails

这些维度不能退：

1. `schema_compliance`
2. `direction_classification`
3. `move_driver_quality`
4. 不把 bearish 写成做空建议
5. 不把 `concept` 和 `supply chain` 混写
6. 不把 `proposed` 当成 `verified`

## 三、重点优化维度

### 1. buy-side usefulness

从会议纪要吸收的要求：

- 更偏“因为相信，所以看见”，而不是“因为看见，所以相信”
- 不是解释昨天为什么涨，而是判断 **今天这条线还值不值得看**
- 尽量避免卖方口吻：泛泛复盘、过度中性、缺乏结论

检查点：

- 有没有明确判断今天的交易价值
- 有没有把“人人都知道”的晚期信息降权
- 有没有给出足够清晰的执行口径

### 2. mapping quality

必须把两条路径拆开：

- `产业逻辑 / supply chain`
- `炒概念 / concept`

检查点：

- 是否明确区分 direct supplier、indirect link、concept proxy
- 是否给出 `verified / inferred / proposed / concept board` 置信来源
- 是否把 stock-specific alpha 和 sector rotation 分开

### 3. timing and propagation stage

会议里反复强调：机会不是只分“有/没有”，还分“早/中/晚”。

推荐用传播阶段来辅助 timing note：

- `1.0`：少数前沿线索，低共识
- `1.5`：领先 KOL / X / 小圈层扩散
- `2.0`：机构和更专业参与者开始跟进
- `3.0`：中国主流财经媒体、散户、概念板块全面扩散

不要求强行输出数字标签，但要体现这个判断。

检查点：

- 有没有区分 `first reaction` / `already running`
- 有没有识别“共识已扩散”的晚期风险
- 有没有把主流媒体全面报道当成潜在卖出或降级信号

### 4. horizon handling

会议里要求同时看短期和中期。

检查点：

- 能否区分 `short-term open trade` 与 `mid-term trend`
- 能否识别 “正常回调但逻辑未坏”
- 避免看到单日下跌就把 thesis 全部推翻

### 5. bearish handling

按产品 spec，loser signal 主要服务于持仓风控。

检查点：

- bearish 是否进入 `risk_alerts`
- 语气是否是“若持有相关 A 股，考虑减仓/规避风险”
- 是否避免输出做空式语言

### 6. move driver grounding

原因判断要尽量 grounded，不要为了前瞻而变成瞎猜。

优先级：

1. 公司 IR / earnings / SEC / official release
2. Reuters / Bloomberg / 高质量财经媒体
3. 行业资料、概念板块、历史关系
4. X / influencer / niche source 作为领先信号或传播阶段参考

X / influencer 可以很有价值，但默认只用来：

- 识别新叙事是否开始扩散
- 判断处在 1.0 / 1.5 / 2.0 哪个阶段
- 提供需要进一步验证的线索

不要把它当唯一事实来源。

### 7. benchmark awareness

来自 spec 的硬要求：

- 默认 benchmark 是 NDX / QQQ
- 还要看 sector ETF
- 最终要能分出：
  - stock-specific alpha
  - sector rotation

检查点：

- 有没有意识到二级 benchmark 的存在
- 对 Mag 7 或大权重股，是否至少在语言上避免把相对强弱理解得过于机械

## 四、当前 phase 的 scope control

当前优化优先服务 phase 1，不要过早把这些当成强制能力：

- 非公开私有数据接入
- 5000 家 A 股全量打标签
- 全自动多跳产业链月度预判
- influencer layer 的全量搭建

这些可以写成：

- bonus
- future direction
- not required for this round

## 五、建议权重

如果需要人工综合评分，可用这个默认权重：

- 25% buy-side usefulness
- 20% mapping quality
- 15% timing and propagation stage
- 15% move driver grounding
- 10% direction handling
- 10% confidence calibration
- 5% schema / transparency polish

注意：schema 与 routing 虽然权重看起来不高，但它们是硬 guardrail，坏了就直接 reject。
