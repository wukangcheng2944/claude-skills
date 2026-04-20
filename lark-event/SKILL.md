---
name: lark-event
description: Use when subscribing to Feishu/Lark events over WebSocket, routing NDJSON event streams, or building event-driven pipelines with lark-cli.
metadata:
  requires:
    bins: ["lark-cli"]
  cliHelp: "lark-cli event --help"
---

# event (v1)

> **閸撳秶鐤嗛弶鈥叉閿?* 閸忓牓妲勭拠?[`../lark-shared/SKILL.md`](../lark-shared/SKILL.md) 娴滃棜袙鐠併倛鐦夐妴浣规綀闂勬劕顦╅悶鍡楁嫲鐎瑰鍙忕憴鍕灟閵?


## Agent-First Output Rule

`event` output must tell the next agent exactly which subscription, route, event type, sink, or websocket state matters most instead of just saying that listening started or nothing arrived.

Always make these explicit:
- `suspected_scope`: subscription, regex route, output sink, auth, websocket state, or event type
- `strongest_evidence`: the key NDJSON sample, connection state, silence window, or error
- `next_best_action`: the single best next listening or verification step
- `next_target`: the exact route, event type, output file, or websocket session to inspect next
- `confidence`: high, medium, or low

## Shortcuts閿涘牊甯归懡鎰喘閸忓牅濞囬悽顭掔礆

Shortcut 閺勵垰顕敮鍝ユ暏閹垮秳缍旈惃鍕彯缁狙冪殱鐟佸拑绱檂lark-cli event +<verb> [flags]`閿涘鈧倹婀?Shortcut 閻ㄥ嫭鎼锋担婊€绱崗鍫滃▏閻劊鈧?

| Shortcut | 鐠囧瓨妲?|
|----------|------|
| [`+subscribe`](references/lark-event-subscribe.md) | Subscribe to Lark events via WebSocket long connection (read-only, NDJSON output); bot-only; supports compact agent-friendly format, regex routing, file output |
