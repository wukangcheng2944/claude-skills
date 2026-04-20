# Golden cases

这些案例不是为了证明事实本身，而是为了固定“这个 agent 应该怎么思考”。

每轮至少选 3 个做人工检查。

## Case 1: corning-style optical demand breakout

### 场景

美国光纤 / 光通信相关公司在纳指偏弱的夜晚显著走强，催化来自 AI 数据中心建设、光纤需求、互联升级或类似叙事。

### 期望行为

- 能识别这更像 `demand / infra build-out`，而不是泛泛“AI 利好”
- 能把 A 股机会拆成：
  - 更偏 `产业逻辑` 的直接链条候选
  - 更偏 `概念映射` 的情绪代理
- timing note 不该只写“可关注”，而要判断是：
  - 第一次反应
  - 已经运行一段时间
  - 回调后仍可跟踪

## Case 2: sandisk-style storage spillover

### 场景

一个美国存储相关名字快速上涨，市场开始把“存储复苏 / AI 拉动存储需求”扩散到中国存储链及大量概念股。

### 期望行为

- 允许 concept spillover 的存在
- 但要把“真正产业受益”与“阿猫阿狗式概念跟涨”分开
- 对低质量概念代理降低 confidence
- 明确提示这类线容易高开后分化

## Case 3: google tpu / pcb / ccl multi-hop chain

### 场景

美国 AI 基建升级首先利好 PCB，再往上游可能传导到覆铜板、树脂等更远一跳。

### 期望行为

- 当前 phase 先把 **最直接的一跳** 当核心信号
- 更远的二跳、三跳可以写进 watchlist 或 next-wave note
- 不要把多跳推导直接包装成高置信当日主信号

## Case 4: thesis-intact pullback

### 场景

一个此前已建立产业逻辑的美国股票，因为大盘 risk-off、VIX 抬升、地缘情绪或流动性冲击而短线回落，但核心产业逻辑未明显破坏。

### 期望行为

- 不要机械地把单日回落改写成 bearish risk alert
- 应能识别“正常波动 / 回踩 / 风险偏好冲击”
- 如果 thesis intact，可写成观察或回调关注，而不是直接否定整个逻辑

## Case 5: consensus-saturated china media stage

### 场景

同花顺、财联社、主流号、散户讨论都在集中传播某条跨境主题，且相关 A 股已经运行多日。

### 期望行为

- 识别这更接近传播后段
- 降低“fresh long” 语气
- 必要时转成 `already running`、`late-stage` 或风险提示

## Case 6: mag 7 sector sentiment layer

### 场景

Mag 7 名字触发强信号，除了个股本身，还显著影响中国相关概念板块情绪。

### 期望行为

- 除个股映射外，额外给出 sector sentiment 判断
- 区分这是 stock-specific alpha 还是 sector rotation
- 不要把所有相关 A 股都写成同样高置信

## Case 7: bearish is a holding-risk alert

### 场景

美国股票因利润率恶化、需求不及预期、并购重组、指引走弱等原因大跌。

### 期望行为

- route 到 `risk_alerts`
- 用“若持有相关 A 股需警惕/考虑减仓/观察反馈”的语言
- 不输出 A 股做空式指令

## Case 8: thin mapping, confidence discipline

### 场景

美国触发信号，但已有 mapping 很薄、很旧，或者只找到概念板块候选。

### 期望行为

- 用 `verified / inferred / proposed / concept board` 明确区分来源
- 不要把薄弱映射写成确定关系
- 宁可保守，也不要为了显得聪明而过度连接
