---
name: lark-doc
description: Use when creating, reading, updating, searching, or attaching content in Feishu/Lark cloud documents through lark-cli docs commands.
metadata:
  requires:
    bins: ["lark-cli"]
  cliHelp: "lark-cli docs --help"
---

# docs (v1)

**CRITICAL 閳?瀵偓婵澧?MUST 閸忓牏鏁?Read 瀹搞儱鍙跨拠璇插絿 [`../lark-shared/SKILL.md`](../lark-shared/SKILL.md)閿涘苯鍙炬稉顓炲瘶閸氼偉顓荤拠浣碘偓浣规綀闂勬劕顦╅悶?*


## Agent-First Output Rule

`docs` results should help the next agent localize the exact document object, token type, block, or permission boundary instead of stopping at "document failed".

Always make these explicit:
- `suspected_scope`: docx, doc, wiki, `file_token`, `obj_token`, block, section, image, or attachment
- `strongest_evidence`: the key URL pattern, token resolution result, block lookup, or command error
- `next_best_action`: the single highest-value next read, resolve, or write step
- `next_target`: the exact token, block id, command, or reference section to inspect next
- `confidence`: high, medium, or low

## 閺嶇绺惧鍌氬悍

### 閺傚洦銆傜猾璇茬€锋稉?Token

妞嬬偘鍔熷鈧弨鎯ч挬閸欓鑵戦敍灞肩瑝閸氬瞼琚崹瀣畱閺傚洦銆傞張澶夌瑝閸氬瞼娈?URL 閺嶇厧绱￠崪?Token 婢跺嫮鎮婇弬鐟扮础閵嗗倸婀潻娑滎攽閺傚洦銆傞幙宥勭稊閿涘牆顩уǎ璇插鐠囧嫯顔戦妴浣风瑓鏉炶姤鏋冩禒鍓佺搼閿涘妞傞敍灞界箑妞よ鍘涢懢宄板絿濮濓絿鈥橀惃?`file_token`閵?

### 閺傚洦銆?URL 閺嶇厧绱℃稉?Token 婢跺嫮鎮?

| URL 閺嶇厧绱?| 缁€杞扮伐                                                      | Token 缁鐎?| 婢跺嫮鎮婇弬鐟扮础 |
|----------|---------------------------------------------------------|-----------|----------|
| `/docx/` | `https://example.larksuite.com/docx/doxcnxxxxxxxxx`    | `file_token` | URL 鐠侯垰绶炴稉顓犳畱 token 閻╁瓨甯存担婊€璐?`file_token` 娴ｈ法鏁?|
| `/doc/` | `https://example.larksuite.com/doc/doccnxxxxxxxxx`     | `file_token` | URL 鐠侯垰绶炴稉顓犳畱 token 閻╁瓨甯存担婊€璐?`file_token` 娴ｈ法鏁?|
| `/wiki/` | `https://example.larksuite.com/wiki/wikcnxxxxxxxxx`    | `wiki_token` | 閳跨媴绗?**娑撳秷鍏橀惄瀛樺复娴ｈ法鏁?*閿涘矂娓剁憰浣稿帥閺屻儴顕楅懢宄板絿閻喎鐤勯惃?`obj_token` |
| `/sheets/` | `https://example.larksuite.com/sheets/shtcnxxxxxxxxx`  | `file_token` | URL 鐠侯垰绶炴稉顓犳畱 token 閻╁瓨甯存担婊€璐?`file_token` 娴ｈ法鏁?|
| `/drive/folder/` | `https://example.larksuite.com/drive/folder/fldcnxxxx` | `folder_token` | URL 鐠侯垰绶炴稉顓犳畱 token 娴ｆ粈璐熼弬鍥︽婢?token 娴ｈ法鏁?|

### Wiki 闁剧偓甯撮悧瑙勭暕婢跺嫮鎮婇敍鍫濆彠闁款噯绱掗敍?

閻儴鐦戞惔鎾绘懠閹恒儻绱檂/wiki/TOKEN`閿涘鍎楅崥搴″讲閼宠姤妲告禍鎴炴瀮濡楋絻鈧胶鏁哥€涙劘銆冮弽绗衡偓浣割樋缂佺銆冮弽鑲╃搼娑撳秴鎮撶猾璇茬€烽惃鍕瀮濡楋絻鈧?*娑撳秷鍏橀惄瀛樺复閸嬪洩顔?URL 娑擃厾娈?token 鐏忚鲸妲?file_token**閿涘苯绻€妞よ鍘涢弻銉嚄鐎圭偤妾猾璇茬€烽崪宀€婀＄€?token閵?

#### 婢跺嫮鎮婂ù浣衡柤

1. **娴ｈ法鏁?`wiki.spaces.get_node` 閺屻儴顕楅懞鍌滃仯娣団剝浼?*
   ```bash
   lark-cli wiki spaces get_node --params '{"token":"wiki_token"}'
   ```

2. **娴犲氦绻戦崶鐐电波閺嬫粈鑵戦幓鎰絿閸忔娊鏁穱鈩冧紖**
   - `node.obj_type`閿涙碍鏋冨锝囪閸ㄥ绱檇ocx/doc/sheet/bitable/slides/file/mindnote閿?
   - `node.obj_token`閿?*閻喎鐤勯惃鍕瀮濡?token**閿涘牏鏁ゆ禍搴℃倵缂侇厽鎼锋担婊愮礆
   - `node.title`閿涙碍鏋冨锝嗙垼妫?

3. **閺嶈宓?`obj_type` 娴ｈ法鏁ょ€电懓绨查惃?API**

   | obj_type | 鐠囧瓨妲?| 娴ｈ法鏁ら惃?API |
   |----------|------|-----------|
   | `docx` | 閺傛壆澧楁禍鎴炴瀮濡?| `drive file.comments.*`閵嗕梗docx.*` |
   | `doc` | 閺冄呭娴滄垶鏋冨?| `drive file.comments.*` |
   | `sheet` | 閻㈤潧鐡欑悰銊︾壐 | `sheets.*` |
   | `bitable` | 婢舵氨娣悰銊︾壐 | `bitable.*` |
   | `slides` | 楠炶崵浼呴悧?| `drive.*` |
   | `file` | 閺傚洣娆?| `drive.*` |
   | `mindnote` | 閹繄娣€电厧娴?| `drive.*` |

#### 閺屻儴顕楃粈杞扮伐

```bash
# 閺屻儴顕?wiki 閼哄倻鍋?
lark-cli wiki spaces get_node --params '{"token":"wiki_token"}'
```

鏉╂柨娲栫紒鎾寸亯缁€杞扮伐閿?
```json
{
   "node": {
      "obj_type": "docx",
      "obj_token": "xxxx",
      "title": "閺嶅洭顣?,
      "node_type": "origin",
      "space_id": "12345678910"
   }
}
```

### 鐠у嫭绨崗宕囬兇

```
Wiki Space (閻儴鐦戠粚娲？)
閳规柡鏀㈤埞鈧?Wiki Node (閻儴鐦戞惔鎾瑰Ν閻?
    閳规壕鏀㈤埞鈧?obj_type: docx (閺傛壆澧楅弬鍥ㄣ€?
    閳?  閳规柡鏀㈤埞鈧?obj_token (閻喎鐤勯弬鍥ㄣ€?token)
    閳规壕鏀㈤埞鈧?obj_type: doc (閺冄呭閺傚洦銆?
    閳?  閳规柡鏀㈤埞鈧?obj_token (閻喎鐤勯弬鍥ㄣ€?token)
    閳规壕鏀㈤埞鈧?obj_type: sheet (閻㈤潧鐡欑悰銊︾壐)
    閳?  閳规柡鏀㈤埞鈧?obj_token (閻喎鐤勯弬鍥ㄣ€?token)
    閳规壕鏀㈤埞鈧?obj_type: bitable (婢舵氨娣悰銊︾壐)
    閳?  閳规柡鏀㈤埞鈧?obj_token (閻喎鐤勯弬鍥ㄣ€?token)
    閳规柡鏀㈤埞鈧?obj_type: file/slides/mindnote
        閳规柡鏀㈤埞鈧?obj_token (閻喎鐤勯弬鍥ㄣ€?token)

Drive Folder (娴滄垹鈹栭梻瀛樻瀮娴犺泛銇?
閳规柡鏀㈤埞鈧?File (閺傚洣娆?閺傚洦銆?
    閳规柡鏀㈤埞鈧?file_token (閻╁瓨甯存担璺ㄦ暏)
```

## 闁插秷顩︾拠瀛樻閿涙氨鏁鹃弶璺ㄧ椽鏉?
> **閳跨媴绗?lark-doc skill 娑撳秷鍏橀惄瀛樺复缂傛牞绶鍙夋箒閻㈢粯婢橀崘鍛啇閿涘奔绲?`docs +update` 閸欘垯浜掗弬鏉跨紦缁岃櫣娅ч悽缁樻緲**
### 閸︾儤娅?1閿涙艾鍑￠柅姘崇箖 docs +fetch 閼惧嘲褰囬崚鐗堟瀮濡楋絽鍞寸€圭懓鎷伴悽缁樻緲 token
婵″倹鐏夐悽銊﹀煕瀹歌尙绮￠柅姘崇箖 `docs +fetch` 閹峰褰囨禍鍡樻瀮濡楋絽鍞寸€圭櫢绱濋獮鏈电瑬閺傚洦銆傛稉顓炲嚒閺堝鏁鹃弶鍖＄礄鏉╂柨娲栭惃?markdown 娑擃厼瀵橀崥?`<whiteboard token="xxx"/>` 閺嶅洨顒烽敍澶涚礉鐠囧嘲绱╃€佃偐鏁ら幋鍑ょ窗
1. 鐠佹澘缍嶉悽缁樻緲閻?token
2. 閺屻儳婀?[`../lark-whiteboard/SKILL.md`](../lark-whiteboard/SKILL.md) 娴滃棜袙婵″倷缍嶇紓鏍帆閻㈢粯婢橀崘鍛啇
### 閸︾儤娅?2閿涙艾鍨伴崚娑樼紦閻㈢粯婢橀敍宀勬付鐟曚胶绱潏?
婵″倹鐏夐悽銊﹀煕閸掓岸鈧俺绻?`docs +update` 閸掓稑缂撴禍鍡欌敄閻х晫鏁鹃弶鍖＄礉闂団偓鐟曚胶绱潏鎴炴閿?
**濮濄儵顎?1閿涙碍瀵滅粚铏规閻㈢粯婢樼拠顓熺《閸掓稑缂?*
- 閸?`--markdown` 娑擃厾娲块幒銉ょ炊 `<whiteboard type="blank"></whiteboard>`
- 闂団偓鐟曚礁顦挎稉顏嗏敄閻х晫鏁鹃弶鎸庢閿涘苯婀崥灞肩娑?`--markdown` 闁插矂鍣告径宥咁樋娑?whiteboard 閺嶅洨顒?
  **濮濄儵顎?2閿涙矮绮犻崫宥呯安娑擃叀顔囪ぐ?token**
- `docs +update` 閹存劕濮涢崥搴礉鐠囪褰囬崫宥呯安鐎涙顔?`data.board_tokens`
- `data.board_tokens` 閺勵垱鏌婂铏规暰閺夎法娈?token 閸掓銆冮敍灞芥倵缂侇厾绱潏鎴犳纯閹恒儰濞囬悽銊ㄧ箹闁插瞼娈?token
  **濮濄儵顎?3閿涙艾绱╃€佃偐绱潏?*
- 鐠佹澘缍嶉棁鈧憰浣虹椽鏉堟垹娈戦悽缁樻緲 token
- 閺屻儳婀?[`../lark-whiteboard/SKILL.md`](../lark-whiteboard/SKILL.md) 娴滃棜袙婵″倷缍嶇紓鏍帆閻㈢粯婢橀崘鍛啇
### 濞夈劍鍓版禍瀣€?
- 瀹稿弶婀侀悽缁樻緲閸愬懎顔愰弮鐘崇《闁俺绻?lark-doc 閻?`docs +update` 閻╁瓨甯寸紓鏍帆
- 缂傛牞绶悽缁樻緲闂団偓鐟曚椒濞囬悽銊ょ瑩闂傘劎娈?[`../lark-whiteboard/SKILL.md`](../lark-whiteboard/SKILL.md)

## 韫囶偊鈧喎鍠呯粵?
- 閻劍鍩涚拠绮光偓婊勫娑撯偓娑擃亣銆冮弽灏栤偓婵冣偓婊勫瘻閸氬秶袨閹兼粎鏁哥€涙劘銆冮弽灏栤偓婵冣偓婊勫閹躲儴銆冮垾婵冣偓婊勬付鏉╂垶澧﹀鈧惃鍕€冮弽灏栤偓婵撶礉閸忓牏鏁?`lark-cli docs +search` 閸嬫俺绁┃鎰絺閻滆埇鈧?
- `docs +search` 娑撳秵妲搁崣顏呮偝閺傚洦銆?/ Wiki閿涙稓绮ㄩ弸婊堝櫡娴兼氨娲块幒銉ㄧ箲閸?`SHEET` 缁涘绨粚娲？鐎电钖勯妴?
- 閹峰灝鍩?spreadsheet URL / token 閸氬函绱濋崘宥呭瀼閸?`lark-sheets` 閸嬫艾顕挒鈥冲敶闁劏顕伴崣鏍モ偓浣虹摣闁鈧礁鍟撻崗銉х搼閹垮秳缍旈妴?

## 鐞涖儱鍘栫拠瀛樻 
`docs +search` 闂勩倓绨￠幖婊呭偍閺傚洦銆?/ Wiki閿涘奔绡冮幍鎸庡閳ユ粌鍘涚€规矮缍呮禍鎴犫敄闂傛潙顕挒鈽呯礉閸愬秴鍨忛崶鐐差嚠鎼存柧绗熼崝?skill 閹垮秳缍旈垾婵堟畱鐠у嫭绨崣鎴犲箛閸忋儱褰涚憴鎺曞閿涙稑缍嬮悽銊﹀煕閸欙絽銇旂拠绮光偓婊嗐€冮弽?/ 閹躲儴銆冮垾婵囨閿涘奔绡冩导妯哄帥娴犲氦绻栭柌灞界磻婵鈧?

## Shortcuts閿涘牊甯归懡鎰喘閸忓牅濞囬悽顭掔礆

Shortcut 閺勵垰顕敮鍝ユ暏閹垮秳缍旈惃鍕彯缁狙冪殱鐟佸拑绱檂lark-cli docs +<verb> [flags]`閿涘鈧倹婀?Shortcut 閻ㄥ嫭鎼锋担婊€绱崗鍫滃▏閻劊鈧?

| Shortcut | 鐠囧瓨妲?|
|----------|------|
| [`+search`](references/lark-doc-search.md) | Search Lark docs, Wiki, and spreadsheet files (Search v2: doc_wiki/search) |
| [`+create`](references/lark-doc-create.md) | Create a Lark document |
| [`+fetch`](references/lark-doc-fetch.md) | Fetch Lark document content |
| [`+update`](references/lark-doc-update.md) | Update a Lark document |
| [`+media-insert`](references/lark-doc-media-insert.md) | Insert a local image or file at the end of a Lark document (4-step orchestration + auto-rollback) |
| [`+media-download`](references/lark-doc-media-download.md) | Download document media or whiteboard thumbnail (auto-detects extension) |
| [`+whiteboard-update`](references/lark-doc-whiteboard-update.md) | Update an existing whiteboard in lark document with whiteboard dsl. Such DSL input from stdin. refer to lark-whiteboard skill for more details. |

