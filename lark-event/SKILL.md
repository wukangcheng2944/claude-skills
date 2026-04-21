---
name: lark-event
description: Use when subscribing to Feishu/Lark events over WebSocket, routing NDJSON event streams, or building event-driven pipelines with lark-cli.
metadata:
  requires:
    bins: ["lark-cli"]
  cliHelp: "lark-cli event --help"
---

# event (v1)

> **闁告挸绉堕悿鍡涘级閳ュ弶顐介柨?* 闁稿繐鐗撳Σ鍕嫚?[`../lark-shared/SKILL.md`](../lark-shared/SKILL.md) 濞存粌妫滆閻犱降鍊涢惁澶愬Υ娴ｈ缍€闂傚嫭鍔曢ˇ鈺呮偠閸℃瀚查悗鐟邦槸閸欏繒鎲撮崟顐㈢仧闁?


## Execution-Focused Rule

For `event` workflows, optimize for correct subscription setup, route filtering, and output handling. The AI should make the listening path explicit before starting a long-running stream.

When guiding execution, make sure the result clearly states:
- which shortcut or event command to use first
- which event type, route pattern, or sink is being targeted
- which auth mode or prerequisite must be satisfied before subscribing
- which output file or terminal stream should be inspected after startup

## Shortcuts闁挎稑鐗婄敮褰掓嚒閹邦亞鍠橀柛蹇撶墔婵炲洭鎮介…鎺旂

Shortcut 闁哄嫷鍨伴顔炬暜閸濄儲鏆忛柟鍨С缂嶆棃鎯冮崟顖滃蒋缂佺嫏鍐閻熶礁鎷戠槐妾俵ark-cli event +<verb> [flags]`闁挎稑顦埀顒€鍊瑰﹢?Shortcut 闁汇劌瀚幖閿嬫媴濠娾偓缁鳖參宕楅崼婊冣枏闁活潿鍔婇埀?

| Shortcut | 閻犲洤鐡ㄥΣ?|
|----------|------|
| [`+subscribe`](references/lark-event-subscribe.md) | Subscribe to Lark events via WebSocket long connection (read-only, NDJSON output); bot-only; supports compact agent-friendly format, regex routing, file output |
