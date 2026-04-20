# Research loop

把 `autoresearch` 的四个核心机制落到这个项目里：

- 窄动作空间
- 固定预算
- 固定评测口径
- accept / reject / rollback

## 0. 本轮计划模板

每轮开始前先写：

- round id:
- baseline prompt version:
- single hypothesis:
- editable surface:
- expected lift:
- guardrails to protect:
- chosen canary cases:

`single hypothesis` 示例：

- 提高 `timing note` 对 “first reaction / already running” 的判断质量
- 提高 `concept` 与 `supply chain` 的分离度
- 提高 bearish 输出进入 `risk_alerts` 的稳定性
- 提高“回调但逻辑未坏”与“逻辑破坏”的区分能力

## 1. 建立 baseline

先备份或提交当前 prompt / 优化文档。不要直接在无基线状态下 auto-apply。

如果仓库支持 git，优先用 git；否则复制 prompt 文件做临时快照。

## 2. baseline 运行配方

默认沿用现有命令，但把它们放进“baseline -> candidate -> compare”的结构里。

### 2.1 删除当日已有 report

```bash
uv run python -c "
from db.pg import get_pool, init_pg_schema
init_pg_schema()
pool = get_pool()
with pool.connection() as conn:
    conn.execute(\"DELETE FROM us_signal_reports WHERE trade_date = (SELECT MAX(trade_date) FROM us_signal_reports)\")
    conn.commit()
"
```

### 2.2 baseline test a

```bash
uv run python main.py us-signal
```

### 2.3 再删一次 report

重复 2.1。

### 2.4 baseline test b

```bash
uv run python main.py us-signal
```

### 2.5 获取最新 trace id

```bash
uv run python -c "
from langsmith import Client
from config.settings import LANGSMITH_API_KEY, LANGSMITH_ENDPOINT
client = Client(api_key=LANGSMITH_API_KEY, api_url=LANGSMITH_ENDPOINT)
runs = list(client.list_runs(project_name='redfi-inverst-agent/us-stocks', is_root=True, limit=1))
print(runs[0].id)
"
```

记录 baseline 的：

- prompt version
- 总分与各维度分数
- 主要 spec gaps
- live trace 中最明显的 1-2 个问题

## 3. 生成 candidate

在 candidate 阶段仍然优先复用现有优化命令：

```bash
uv run python main.py optimize-prompt --trace-id <TRACE_ID> --auto-apply
```

但要额外做两件事：

1. **限制 edit surface**：如果 auto-apply 改动超出了本轮允许范围，手工裁剪或回退多余改动
2. **显式检查 diff**：确认它没有悄悄改坏 schema、tool policy 或 phase 边界

## 4. candidate 验证

对 candidate 重新跑两次，与 baseline 使用同一配方：

1. 删除最新 report
2. 跑 `uv run python main.py us-signal`
3. 删除最新 report
4. 再跑一次 `uv run python main.py us-signal`

然后记录：

- candidate prompt version
- 总分与各维度分数
- 新增 spec gaps
- 被修复的问题
- 是否出现新 hallucination / 过度推断 / 过度乐观

## 5. 固定 canary case 检查

不要只看最新真实 trace。live 数据噪声很大。

每轮至少拿 3 个 `golden-cases.md` 里的案例做人工检查：

- 如果 live trace 提升了，但 canary 退化了，默认不要接受
- 如果 live trace 噪声大，但 canary 明显更稳，可记为“待观察”而不是立即推广

## 6. accept / reject 规则

### 6.1 默认接受条件

只有在以下条件同时满足时才接受：

- 没有触发 hard guardrail
- 主目标 `next-day actionable signal quality` 改善
- 关键维度至少一项明确提升：
  - timing note
  - mapping quality
  - confidence calibration
  - direction routing
  - move driver grounding
- canary cases 没有出现明显回归

### 6.2 默认拒绝条件

出现以下任一情况直接 reject：

- schema / routing 出错
- candidate 只是写得更长，但更不 actionable
- 把会议里的前瞻性要求误解成无依据的超前猜测
- 把多跳产业链写成高置信当日核心信号
- 把中国主流媒体热议阶段误判成“新机会”

## 7. 回滚

reject 后立即回到 baseline 快照，不要把坏版本留在主线上。

## 8. 默认轮次与提前停止

- 默认 3 轮
- 连续 2 轮被 reject，且问题类型重复，提前停止
- 如果某一轮已经把主问题修复且没有新回归，也可以提前停止

## 9. 每轮输出模板

```text
round: <n>
baseline version: <v>
candidate version: <v2>
single hypothesis: <...>
editable surface: <...>

baseline summary:
- total score:
- key strengths:
- key gaps:

candidate summary:
- total score:
- key strengths:
- key gaps:

canary check:
- passed:
- regressed:

verdict:
- accept / reject
- why:
- next hypothesis:
```
