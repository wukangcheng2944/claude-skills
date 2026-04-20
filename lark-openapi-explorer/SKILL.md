---
name: lark-openapi-explorer
description: Use when existing lark-* skills or registered lark-cli commands cannot satisfy a request and native Feishu/Lark OpenAPI discovery is required.
metadata:
  requires:
    bins: ["lark-cli"]
---

# OpenAPI Explorer

> **閸撳秶鐤嗛弶鈥叉閿?* 閸忓牓妲勭拠?[`../lark-shared/SKILL.md`](../lark-shared/SKILL.md) 娴滃棜袙鐠併倛鐦夐妴浣介煩娴犺棄鍨忛幑銏犳嫲鐎瑰鍙忕憴鍕灟閵?

瑜版挾鏁ら幋椋庢畱闂団偓濮?*閺冪姵纭剁悮顐ゅ箛閺?skill 閹?CLI 瀹稿弶鏁為崘?API 鐟曞棛娲?*閺冭绱濇担璺ㄦ暏閺堫剚濡ч懗鎴掔矤妞嬬偘鍔熺€规ɑ鏌?markdown 閺傚洦銆傛惔鎾茶厬闁劕鐪伴幐鏍ㄥ涪閸樼喓鏁?OpenAPI 閹恒儱褰涢敍宀€鍔ч崥搴ㄢ偓姘崇箖 `lark-cli api` 鐟佹瓕鐨熺€瑰本鍨氭禒璇插閵?


## Agent-First Output Rule

This skill exists to shrink API search space. It should never stop at "no API found" without naming the most likely module, document, or fallback path for the next agent.

Always make these explicit:
- `suspected_scope`: the most likely module, document node, API group, or resource
- `strongest_evidence`: the key clue from `llms.txt`, module markdown, or API doc
- `next_best_action`: continue digging, call `lark-cli api`, or fall back to an existing CLI capability
- `next_target`: the exact module doc, markdown file, or API path to inspect next
- `confidence`: high, medium, or low

## 閺傚洦銆傛惔鎾剁波閺?

妞嬬偘鍔?OpenAPI 閺傚洦銆傛禒?markdown 鐏炲倻楠囩紒鍕矏閿?

```
llms.txt                          閳?妞よ泛鐪扮槐銏犵穿閿涘苯鍨崙鐑樺閺堝膩閸ф鏋冨锝夋懠閹?
  閳规柡鏀?llms-<module>.txt            閳?濡€虫健閺傚洦銆傞敍灞藉瘶閸氼偄濮涢懗鑺ヮ洤鏉?+ 鎼存洖鐪?API 閺傚洦銆傞柧鐐复
       閳规柡鏀?<api-doc>.md            閳?閸楁洑閲?API 閻ㄥ嫬鐣弫纾嬵嚛閺勫函绱欓弬瑙勭《/鐠侯垰绶?閸欏倹鏆?閸濆秴绨?闁挎瑨顕ら惍渚婄礆
```

閺傚洦銆傞崗銉ュ經閿?

| 閸濅胶澧?| 閸忋儱褰?URL |
|------|----------|
| 妞嬬偘鍔?(Feishu) | `https://open.feishu.cn/llms.txt` |
| Lark | `https://open.larksuite.com/llms.txt` |

> 閹碘偓閺堝鏋冨锝勪簰**娑擃厽鏋?*缂傛牕鍟撻妴鍌氼洤閺嬫粎鏁ら幋铚傚▏閻劏瀚抽弬鍥︽唉濞翠緤绱濋棁鈧亸鍡樻瀮濡楋絽鍞寸€瑰湱鐐曠拠鎴滆礋閼昏鲸鏋冮崥搴ょ翻閸戞亽鈧?

## 閹告牗甯㈠ù浣衡柤

娑撱儲鐗搁幐澶変簰娑撳顒炴銈夆偓鎰湴濡偓缁鳖澁绱?*娑撳秷顩︾捄铏劄閹存牜瀵藉ù?API**閿?

### Step 1閿涙氨鈥樼拋銈囧箛閺堝鍏橀崝娑楃瑝鐡?

```bash
# 閸忓牊顥呴弻銉︽Ц閸氾箑鍑￠張澶婎嚠鎼存梻娈?skill 閹存牕鍑″▔銊ュ斀 API
lark-cli <閸欘垵鍏橀惃鍓唀rvice> --help
```

婵″倹鐏夊鍙夋箒鐎电懓绨查崨鎴掓姢閹?shortcut閿涘瞼娲块幒銉ゅ▏閻㈩煉绱?*娑撳秹娓剁憰浣烘埛缂侇厽瀵查幒?*閵?

### Step 2閿涙矮绮犳い璺虹湴缁便垹绱╃€规矮缍呭Ο鈥虫健

閻?WebFetch 閼惧嘲褰囨い璺虹湴缁便垹绱╅敍灞惧閸掗绗岄棁鈧Ч鍌滄祲閸忓磭娈戝Ο鈥虫健閺傚洦銆傞柧鐐复閿?

```
WebFetch https://open.feishu.cn/llms.txt
  閳?閹绘劕褰囬梻顕€顣介敍?閸掓鍤幍鈧張澶嬆侀崸妤佹瀮濡楋綁鎽奸幒銉礉閹垫儳鍤稉?<閻劍鍩涢棁鈧Ч鍌氬彠闁款喛鐦? 閻╃鍙ч惃鍕懠閹?
```

- 妞嬬偘鍔熼崫浣哄娴ｈ法鏁?`open.feishu.cn`
- Lark 閸濅胶澧濇担璺ㄦ暏 `open.larksuite.com`
- 婵″倷绗夌涵顔肩暰閻劍鍩涢崫浣哄閿涘矂绮拋銈勫▏閻劑顥ｆ稊?

### Step 3閿涙矮绮犲Ο鈥虫健閺傚洦銆傜€规矮缍呴崗铚傜秼 API

閻?WebFetch 閼惧嘲褰囧Ο鈥虫健閺傚洦銆傞敍灞惧閸掓澘鍙挎担?API 閻ㄥ嫭鏋冨锝夋懠閹恒儻绱?

```
WebFetch https://open.feishu.cn/llms-docs/zh-CN/llms-<module>.txt
  閳?閹绘劕褰囬梻顕€顣介敍?閹垫儳鍤稉?<閻劍鍩涢棁鈧Ч? 閻╃鍙ч惃?API 鐠囧瓨妲戦崪灞炬瀮濡楋綁鎽奸幒?
```

### Step 4閿涙俺骞忛崣?API 鐎瑰本鏆ｇ憴鍕瘱

閻?WebFetch 閼惧嘲褰囬崗铚傜秼 API 閺傚洦銆傞敍灞惧絹閸欐牕鐣弫瀵告畱鐠嬪啰鏁ょ憴鍕瘱閿?

```
WebFetch https://open.feishu.cn/document/server-docs/.../<api>.md
  閳?閹绘劕褰囬梻顕€顣介敍?鏉╂柨娲栫€瑰本鏆?API 鐟欏嫯瀵栭敍娆籘TP 閺傝纭堕妴涔丷L 鐠侯垰绶為妴浣界熅瀵板嫬寮弫鑸偓浣圭叀鐠囥垹寮弫鑸偓浣筋嚞濮瑰倷缍嬬€涙顔岄敍鍫濇倳缁?缁鐎?韫囧懎锝?鐠囧瓨妲戦敍澶堚偓浣告惙鎼存柨鐡у▓鐐光偓浣瑰闂団偓閺夊啴妾洪妴渚€鏁婄拠顖滅垳"
```

### Step 5閿涙岸鈧俺绻?CLI 鐠嬪啰鏁?API

娴ｈ法鏁?`lark-cli api` 鐟佹瓕鐨熼敍?

```bash
# GET 鐠囬攱鐪?
lark-cli api GET /open-apis/<path> --params '{"key":"value"}'

# POST 鐠囬攱鐪?
lark-cli api POST /open-apis/<path> --data '{"key":"value"}'

# PUT 鐠囬攱鐪?
lark-cli api PUT /open-apis/<path> --data '{"key":"value"}'

# DELETE 鐠囬攱鐪?
lark-cli api DELETE /open-apis/<path>
```

## 鏉堟挸鍤憴鍕瘱

閸氭垹鏁ら幋宄版啛閻滅増瀵查幒妯肩波閺嬫粍妞傞敍灞惧瘻娴犮儰绗呴弽鐓庣础缂佸嫮绮愰敍?

1. **API 閸氬秶袨娑撳骸濮涢懗?*閿涙矮绔撮崣銉ㄧ樈閹诲繗鍫?
2. **HTTP 閺傝纭舵稉搴ょ熅瀵?*閿涙瓪METHOD /open-apis/...`
3. **閸忔娊鏁崣鍌涙殶**閿涙艾鍨崙鍝勭箑婵夘偄鎷扮敮鍝ユ暏閸欘垶鈧寮弫?
4. **閹碘偓闂団偓閺夊啴妾?*閿涙cope 閸掓銆?
5. **鐠嬪啰鏁ょ粈杞扮伐**閿涙氨绮伴崙?`lark-cli api` 閻ㄥ嫬鐣弫鏉戞嚒娴?
6. **濞夈劍鍓版禍瀣€?*閿涙岸顣堕悳鍥閸掕翰鈧胶澹掑▓濠勫閺夌喓鐡?

婵″倹鐏夐悽銊﹀煕娴ｈ法鏁ら懟杈ㄦ瀮娴溿倖绁﹂敍灞界殺娴犮儰绗傞幍鈧張澶婂敶鐎瑰湱鐐曠拠鎴滆礋閼昏鲸鏋冮妴?

## 鐎瑰鍙忕憴鍕灟

- **閸愭瑥鍙?閸掔娀娅庣猾?API**閿涘湧OST/PUT/DELETE閿涘鐨熼悽銊ュ韫囧懘銆忕涵顔款吇閻劍鍩涢幇蹇撴禈
- 瀵ら缚顔呴崗鍫㈡暏 `--dry-run` 妫板嫯顫嶇拠閿嬬湴閿涘牆顩ч弨顖涘瘮閿?
- 娑撳秷顩﹂悮婊勭ゴ API 鐠侯垰绶為幋鏍у棘閺佹壋鈧柡鈧柨绻€妞よ绮犻弬鍥ㄣ€傛稉顓″箯閸欐牜鈥樼拋?
- 濞戝寮烽弫蹇斿妳閹垮秳缍旈敍鍫濆灩闂勩倗鍏㈤妴浣盒╅梽銈嗗灇閸涙鐡戦敍澶嬫閿涘苯鎮滈悽銊﹀煕鐠囧瓨妲戣ぐ鍗炴惙閼煎啫娲?

## 娴ｈ法鏁ら崷鐑樻珯缁€杞扮伐

### 閸︾儤娅?1閿涙氨鏁ら幋鐑芥付鐟曚焦濯烘禍楦跨箻缂囥倧绱欓張顏囶潶 CLI 鐏忎浇顥婇敍?

```bash
# Step 1: 绾喛顓?CLI 濞屸剝婀佺亸浣筋棅
lark-cli im --help
# 閳?閸欐垹骞囧▽鈩冩箒 chat_members 閻╃鍙ч惃?create 閸涙垝鎶?

# Step 2-4: 闁俺绻冮弬鍥ㄣ€傞幐鏍ㄥ涪閼惧嘲绶?API 鐟欏嫯瀵?
# 閳?POST /open-apis/im/v1/chats/:chat_id/members

# Step 5: 鐠嬪啰鏁?
lark-cli api POST /open-apis/im/v1/chats/oc_xxx/members \
  --data '{"id_list":["ou_xxx","ou_yyy"]}' \
  --params '{"member_id_type":"open_id"}'
```

### 閸︾儤娅?2閿涙氨鏁ら幋鐑芥付鐟曚浇顔曠純顔惧參閸忣剙鎲?

```bash
# Step 1: 绾喛顓?CLI 濞屸剝婀佺亸浣筋棅
lark-cli im --help
# 閳?濞屸剝婀?announcement 閻╃鍙ч崨鎴掓姢

# Step 2-4: 閹告牗甯㈤弬鍥ㄣ€?
# 閳?PATCH /open-apis/im/v1/chats/:chat_id/announcement

# Step 5: 鐠嬪啰鏁?
lark-cli api PATCH /open-apis/im/v1/chats/oc_xxx/announcement \
  --data '{"revision":"0","requests":["<html>閸忣剙鎲￠崘鍛啇</html>"]}'
```

## 閸欏倽鈧?

- [lark-shared](../lark-shared/SKILL.md) 閳?鐠併倛鐦夐崪灞藉弿鐏炩偓閸欏倹鏆?
- [lark-skill-maker](../lark-skill-maker/SKILL.md) 閳?婵″倿娓剁亸鍡樺閹烘ê鍩岄惃?API 閸ュ搫瀵叉稉鐑樻煀 Skill
