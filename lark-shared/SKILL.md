---
name: lark-shared
description: Shared guidance for configuring and authenticating lark-cli, switching identity, handling scope and permission issues, and applying basic safety rules.
metadata:
  requires:
    bins: ["lark-cli"]
---

# lark-cli 閸忓彉闊╃憴鍕灟

閺堫剚濡ч懗鑺ュ瘹鐎甸棿缍樻俊鍌欑秿闁俺绻僱ark-cli閹垮秳缍旀鐐板姛鐠у嫭绨? 娴犮儱寮烽張澶婃憿娴滄稒鏁為幇蹇庣皑妞ゅ箍鈧?


## Agent-First Output Rule

This shared skill must help the next agent localize the smallest failing boundary instead of stopping at "auth failed" or "permission denied".

Always make these explicit in the result:
- `suspected_scope`: auth, identity (`user`/`bot`), scope, app config, or command layer
- `strongest_evidence`: the key CLI output, missing scope, config mismatch, or permission error
- `next_best_action`: the single highest-value next step
- `next_target`: the exact command, config field, identity, or permission to inspect next
- `confidence`: high, medium, or low

## 闁板秶鐤嗛崚婵嗩潗閸?

妫ｆ牗顐兼担璺ㄦ暏闂団偓鏉╂劘顢?`lark-cli config init` 鐎瑰本鍨氭惔鏃傛暏闁板秶鐤嗛妴?

瑜版挷缍樼敮顔炬暏閹村嘲鍨垫慨瀣闁板秶鐤嗛弮璁圭礉娴ｈ法鏁ackground閺傜懓绱℃担璺ㄦ暏娑撳娼伴惃鍕嚒娴犮倕褰傜挧鐑藉帳缂冾喖绨查悽銊︾ウ缁嬪绱濋崥顖氬З閸氬氦顕伴崣鏍翻閸戠尨绱濇禒搴濊厬閹绘劕褰囬幒鍫熸綀闁剧偓甯撮獮璺哄絺缂佹瑧鏁ら幋鍑ょ窗

```bash
# 閸欐垼鎹ｉ柊宥囩枂閿涘牐顕氶崨鎴掓姢娴兼岸妯嗘繅鐐垫纯閸掓壆鏁ら幋閿嬪ⅵ瀵偓闁剧偓甯撮獮璺虹暚閹存劖鎼锋担婊勫灗鏉╁洦婀￠敍?
lark-cli config init --new
```

## 鐠併倛鐦?

### 闊偂鍞ょ猾璇茬€?

娑撱倗顫掗煬顐″敜缁鐎烽敍宀勨偓姘崇箖 `--as` 閸掑洦宕查敍?

| 闊偂鍞?| 閺嶅洩鐦?| 閼惧嘲褰囬弬鐟扮础 | 闁倻鏁ら崷鐑樻珯 |
|------|------|---------|---------|
| user 閻劍鍩涢煬顐″敜 | `--as user` | `lark-cli auth login` 缁?| 鐠佸潡妫堕悽銊﹀煕閼奉亜绻侀惃鍕カ濠ф劧绱欓弮銉ュ坊閵嗕椒绨粚娲？缁涘绱?|
| bot 鎼存梻鏁ら煬顐″敜 | `--as bot` | 閼奉亜濮╅敍灞藉涧闂団偓 appId + appSecret | 鎼存梻鏁ょ痪褎鎼锋担?鐠佸潡妫禸ot閼奉亜绻侀惃鍕カ濠?|

### 闊偂鍞ら柅澶嬪閸樼喎鍨?

鏉堟挸鍤惃?`[identity: bot/user]` 娴狅綀銆冭ぐ鎾冲闊偂鍞ら妴淇爋t 娑?user 鐞涖劎骞囧顔肩磽瀵板牆銇囬敍宀勬付绾喛顓婚煬顐″敜缁楋箑鎮庨惄顔界垼闂団偓濮瑰偊绱?

- **Bot 閻绗夐崚鎵暏閹寸柉绁┃?*閿涙碍妫ゅ▔鏇☆問闂傤喚鏁ら幋椋庢畱閺冦儱宸婚妴浣风隘缁屾椽妫块弬鍥ㄣ€傞妴渚€鍋栫粻杈╃搼娑擃亙姹夌挧鍕爱閵嗗倷绶ユ俊?`--as bot` 閺屻儲妫╃粙瀣箲閸?bot 閼奉亜绻侀惃鍕剁礄缁岀尨绱氶弮銉ュ坊
- **Bot 閺冪姵纭舵禒锝堛€冮悽銊﹀煕閹垮秳缍?*閿涙艾褰傚☉鍫熶紖娴犮儱绨查悽銊ユ倳娑斿褰傞柅渚婄礉閸掓稑缂撻弬鍥ㄣ€傝ぐ鎺戠潣 bot
- **Bot 閺夊啴妾?*閿涙艾褰ч棁鈧崷銊╊棧娑旓箑绱戦崣鎴ｂ偓鍛倵閸欐澘绱戦柅?scope閿涘本妫ら棁鈧?`auth login`
- **User 閺夊啴妾?*閿涙艾鎮楅崣鏉跨磻闁?scope + 閻劍鍩涢柅姘崇箖 `auth login` 閹哄牊娼堥敍灞艰⒈鐏炲倿鍏樼憰浣瑰姬鐡?


### 閺夊啴妾烘稉宥堝喕婢跺嫮鎮?

闁洤鍩岄弶鍐閻╃鍙ч柨娆掝嚖閺冭绱?*閺嶈宓佽ぐ鎾冲闊偂鍞ょ猾璇茬€烽柌鍥у絿娑撳秴鎮撶憴锝呭枀閺傝顢?*閵?

闁挎瑨顕ら崫宥呯安娑擃厼瀵橀崥顐㈠彠闁款喕淇婇幁顖ょ窗
- `permission_violations`閿涙艾鍨崙铏瑰繁婢惰京娈?scope (N闁?)
- `console_url`閿涙岸顥ｆ稊锕€绱戦崣鎴ｂ偓鍛倵閸欐壆娈戦弶鍐闁板秶鐤嗛柧鐐复
- `hint`閿涙艾缂撶拋顔炬畱娣囶喖顦查崨鎴掓姢

#### Bot 闊偂鍞ら敍鍧?-as bot`閿?

鐏忓棝鏁婄拠顖欒厬閻?`console_url` 閹绘劒绶电紒娆戞暏閹村嚖绱濆鏇烆嚤閸樿鎮楅崣鏉跨磻闁?scope閵?*缁備焦顒?*鐎?bot 閹笛嗩攽 `auth login`閵?

#### User 闊偂鍞ら敍鍧?-as user`閿?

```bash
lark-cli auth login --domain <domain>           # 閹稿绗熼崝鈥崇厵閹哄牊娼?
lark-cli auth login --scope "<missing_scope>"   # 閹稿鍙挎担?scope 閹哄牊娼堥敍鍫熷腹閼?缁楋箑鎮庨張鈧亸蹇旀綀闂勬劕甯崚娆欑礆
```

**鐟欏嫬鍨?*閿涙瓫uth login 韫囧懘銆忛幐鍥х暰閼煎啫娲块敍鍧?-domain` 閹?`--scope`閿涘鈧倸顦垮▎?login 閻?scope 娴兼氨鐤粔顖ょ礄婢х偤鍣洪幒鍫熸綀閿涘鈧?

#### Agent 娴狅絿鎮婇崣鎴ｆ崳鐠併倛鐦夐敍鍫熷腹閼芥劧绱?

瑜版挷缍樻担婊€璐?AI agent 闂団偓鐟曚礁搴滈悽銊﹀煕鐎瑰本鍨氱拋銈堢槈閺冭绱濇担璺ㄦ暏background閺傜懓绱?閹笛嗩攽娴犮儰绗呴崨鎴掓姢閸欐垼鎹ｉ幒鍫熸綀濞翠胶鈻? 楠炶泛鐨㈤幒鍫熸綀闁剧偓甯撮崣鎴犵舶閻劍鍩涢敍?

```bash
# 閸欐垼鎹ｉ幒鍫熸綀閿涘牓妯嗘繅鐐垫纯閸掓壆鏁ら幋閿嬪房閺夊啫鐣幋鎰灗鏉╁洦婀￠敍?
lark-cli auth login --scope "calendar:calendar:readonly"

```


## 鐎瑰鍙忕憴鍕灟

- **缁備焦顒涙潏鎾冲毉鐎靛棝鎸?*閿涘潊ppSecret閵嗕工ccessToken閿涘鍩岀紒鍫㈩伂閺勫孩鏋冮妴?
- **閸愭瑥鍙?閸掔娀娅庨幙宥勭稊閸撳秴绻€妞よ崵鈥樼拋銈囨暏閹撮攱鍓伴崶?*閵?
- 閻?`--dry-run` 妫板嫯顫嶉崡閬嶆珦鐠囬攱鐪伴妴?
