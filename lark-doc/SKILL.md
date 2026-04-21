---
name: lark-doc
description: Use when creating, reading, updating, searching, or attaching content in Feishu/Lark cloud documents through lark-cli docs commands.
metadata:
  requires:
    bins: ["lark-cli"]
  cliHelp: "lark-cli docs --help"
---

# docs (v1)

**CRITICAL 闁?鐎殿喒鍋撳┑顔碱儏婢?MUST 闁稿繐鐗忛弫?Read 鐎规悶鍎遍崣璺ㄦ嫚鐠囨彃绲?[`../lark-shared/SKILL.md`](../lark-shared/SKILL.md)闁挎稑鑻崣鐐▔椤撶偛鐦堕柛姘煎亯椤撹崵鎷犳担纰樺亾娴ｈ缍€闂傚嫭鍔曢ˇ鈺呮偠?*


## Execution-Focused Rule

For `docs` workflows, optimize for choosing the right document object, token type, and write method. The AI should avoid ambiguous token handling and mutate only after the target object is confirmed.

When guiding execution, make sure the result clearly states:
- which document type is in play: `docx`, `doc`, `wiki`, attachment, image, or folder-backed object
- which token or block id must be resolved first
- which command should be used next
- which read or search step is required before attempting an update

## 闁哄秶顭堢缓鎯ь潡閸屾艾鎮?

### 闁哄倸娲﹂妴鍌滅尵鐠囪尙鈧攱绋?Token

濡炲鍋橀崝鐔奉嚕閳ь剟寮ㄩ幆褔鎸柛娆擃暒閼垫垿鏁嶇仦鑲╃憹闁告艾鐬肩悮顐﹀垂鐎ｎ剚鐣遍柡鍌氭处閵嗗倿寮垫径澶岀憹闁告艾鐬煎▓?URL 闁哄秶鍘х槐锟犲椽?Token 濠㈣泛瀚幃濠囧棘閻熸壆纭€闁靛棗鍊稿﹢顏呮交濞戞粠鏀介柡鍌氭处閵嗗倿骞欏鍕▕闁挎稑鐗嗛々褍菐鐠囨彃顫ｉ悹鍥у椤旀垿濡存担椋庣憮閺夌偠濮ら弸鍐╃閸撲胶鎼奸柨娑橆槹濡炲倿鏁嶇仦鐣岀畱濡炪倛顕ч崢娑㈡嚔瀹勬澘绲挎慨婵撶悼閳ユ﹢鎯?`file_token`闁?

### 闁哄倸娲﹂妴?URL 闁哄秶鍘х槐鈩冪▔?Token 濠㈣泛瀚幃?

| URL 闁哄秶鍘х槐?| 缂佲偓鏉炴壆浼?                                                     | Token 缂侇偉顕ч悗?| 濠㈣泛瀚幃濠囧棘閻熸壆纭€ |
|----------|---------------------------------------------------------|-----------|----------|
| `/docx/` | `https://example.larksuite.com/docx/doxcnxxxxxxxxx`    | `file_token` | URL 閻犱警鍨扮欢鐐寸▔椤撶姵鐣?token 闁烩晛鐡ㄧ敮瀛樻媴濠娾偓鐠?`file_token` 濞达綀娉曢弫?|
| `/doc/` | `https://example.larksuite.com/doc/doccnxxxxxxxxx`     | `file_token` | URL 閻犱警鍨扮欢鐐寸▔椤撶姵鐣?token 闁烩晛鐡ㄧ敮瀛樻媴濠娾偓鐠?`file_token` 濞达綀娉曢弫?|
| `/wiki/` | `https://example.larksuite.com/wiki/wikcnxxxxxxxxx`    | `wiki_token` | 闁宠法濯寸粭?**濞戞挸绉烽崗姗€鎯勭€涙ê澶嶅ù锝堟硶閺?*闁挎稑鐭傚〒鍓佹啺娴ｇ甯ラ柡灞诲劥椤曟鎳㈠畡鏉跨悼闁活亞鍠庨悿鍕儍?`obj_token` |
| `/sheets/` | `https://example.larksuite.com/sheets/shtcnxxxxxxxxx`  | `file_token` | URL 閻犱警鍨扮欢鐐寸▔椤撶姵鐣?token 闁烩晛鐡ㄧ敮瀛樻媴濠娾偓鐠?`file_token` 濞达綀娉曢弫?|
| `/drive/folder/` | `https://example.larksuite.com/drive/folder/fldcnxxxx` | `folder_token` | URL 閻犱警鍨扮欢鐐寸▔椤撶姵鐣?token 濞达絾绮堢拹鐔煎棘閸ワ附顐藉?token 濞达綀娉曢弫?|

### Wiki 闂佸墽鍋撶敮鎾偋鐟欏嫮鏆曞璺哄閹﹪鏁嶉崼婵嗗綘闂佹鍣槐鎺楁晬?

闁活厹鍎撮惁鎴炴償閹剧粯鎳犻柟鎭掑劵缁辨獋/wiki/TOKEN`闁挎稑顦抽崕妤呭触鎼粹€宠闁煎疇濮ゅΣ鍛婄閹寸偞鐎俊妤嬬祷閳ь兛鑳堕弫鍝モ偓娑欏姌閵嗗啴寮界粭琛″亾娴ｅ壊妯嬬紓浣侯棎閵嗗啴寮介懖鈺冩惣濞戞挸绉撮幃鎾剁尵鐠囪尙鈧兘鎯冮崟顒佺€俊妤嬬祷閳?*濞戞挸绉烽崗姗€鎯勭€涙ê澶嶉柛瀣穿椤?URL 濞戞搩鍘惧▓?token 閻忓繗椴稿Σ?file_token**闁挎稑鑻换鈧銈堫嚙閸樻盯寮婚妷顭戝殑閻庡湱鍋ゅ顖滅尵鐠囪尙鈧兘宕畝鈧﹢锛勨偓?token闁?

#### 濠㈣泛瀚幃濠偯规担琛℃煠

1. **濞达綀娉曢弫?`wiki.spaces.get_node` 闁哄被鍎撮妤呮嚍閸屾粌浠ǎ鍥ｅ墲娴?*
   ```bash
   lark-cli wiki spaces get_node --params '{"token":"wiki_token"}'
   ```

2. **濞寸姴姘︾换鎴﹀炊閻愮數娉㈤柡瀣矆閼垫垿骞撻幇顒€绲块柛蹇斿▕閺侇厽绌遍埄鍐х礀**
   - `node.obj_type`闁挎稒纰嶉弸鍐浖閿濆洩顫﹂柛銊ヮ儜缁辨獓ocx/doc/sheet/bitable/slides/file/mindnote闁?
   - `node.obj_token`闁?*闁活亞鍠庨悿鍕儍閸曨剚鐎俊?token**闁挎稑鐗忛弫銈嗙鎼粹剝鍊电紓渚囧幗閹奸攱鎷呭鎰
   - `node.title`闁挎稒纰嶉弸鍐浖閿濆棛鍨煎Λ?

3. **闁哄秷顫夊畵?`obj_type` 濞达綀娉曢弫銈団偓鐢垫嚀缁ㄦ煡鎯?API**

   | obj_type | 閻犲洤鐡ㄥΣ?| 濞达綀娉曢弫銈夋儍?API |
   |----------|------|-----------|
   | `docx` | 闁哄倹澹嗘晶妤佺閹寸偞鐎俊?| `drive file.comments.*`闁靛棔姊梔ocx.*` |
   | `doc` | 闁哄唲鍛暭濞存粍鍨堕弸鍐浖?| `drive file.comments.*` |
   | `sheet` | 闁汇垽娼ч悺娆戞偘閵婏妇澹?| `sheets.*` |
   | `bitable` | 濠㈣埖姘ㄥǎ顔炬偘閵婏妇澹?| `bitable.*` |
   | `slides` | 妤犵偠宕垫导鍛存偋?| `drive.*` |
   | `file` | 闁哄倸娲ｅ▎?| `drive.*` |
   | `mindnote` | 闁诡剚绻勫ǎ顔锯偓鐢靛帶濞?| `drive.*` |

#### 闁哄被鍎撮妤冪矆鏉炴壆浼?

```bash
# 闁哄被鍎撮?wiki 闁煎搫鍊婚崑?
lark-cli wiki spaces get_node --params '{"token":"wiki_token"}'
```

閺夆晜鏌ㄥú鏍磼閹惧浜紒鈧潪鎵紣闁?
```json
{
   "node": {
      "obj_type": "docx",
      "obj_token": "xxxx",
      "title": "闁哄秴娲。?,
      "node_type": "origin",
      "space_id": "12345678910"
   }
}
```

### 閻犙冨缁噣宕楀畷鍥厙

```
Wiki Space (闁活厹鍎撮惁鎴犵矚濞差亝锛?
闁宠鏌￠弨銏ゅ煘閳?Wiki Node (闁活厹鍎撮惁鎴炴償閹剧懓螡闁?
    闁宠澹曢弨銏ゅ煘閳?obj_type: docx (闁哄倹澹嗘晶妤呭棘閸ャ劊鈧?
    闁?  闁宠鏌￠弨銏ゅ煘閳?obj_token (闁活亞鍠庨悿鍕棘閸ャ劊鈧?token)
    闁宠澹曢弨銏ゅ煘閳?obj_type: doc (闁哄唲鍛暭闁哄倸娲﹂妴?
    闁?  闁宠鏌￠弨銏ゅ煘閳?obj_token (闁活亞鍠庨悿鍕棘閸ャ劊鈧?token)
    闁宠澹曢弨銏ゅ煘閳?obj_type: sheet (闁汇垽娼ч悺娆戞偘閵婏妇澹?
    闁?  闁宠鏌￠弨銏ゅ煘閳?obj_token (闁活亞鍠庨悿鍕棘閸ャ劊鈧?token)
    闁宠澹曢弨銏ゅ煘閳?obj_type: bitable (濠㈣埖姘ㄥǎ顔炬偘閵婏妇澹?
    闁?  闁宠鏌￠弨銏ゅ煘閳?obj_token (闁活亞鍠庨悿鍕棘閸ャ劊鈧?token)
    闁宠鏌￠弨銏ゅ煘閳?obj_type: file/slides/mindnote
        闁宠鏌￠弨銏ゅ煘閳?obj_token (闁活亞鍠庨悿鍕棘閸ャ劊鈧?token)

Drive Folder (濞存粍鍨归埞鏍⒒鐎涙ɑ鐎ù鐘烘硾閵?
闁宠鏌￠弨銏ゅ煘閳?File (闁哄倸娲ｅ▎?闁哄倸娲﹂妴?
    闁宠鏌￠弨銏ゅ煘閳?file_token (闁烩晛鐡ㄧ敮瀛樻媴鐠恒劍鏆?
```

## 闂佹彃绉烽々锔炬嫚鐎涙ɑ顫栭柨娑欐皑閺侀箖寮剁捄銊фそ閺?
> **闁宠法濯寸粭?lark-doc skill 濞戞挸绉烽崗姗€鎯勭€涙ê澶嶇紓鍌涚墳缁额偄顔忛崣澶嬬畳闁汇垻绮姗€宕橀崨顓у晣闁挎稑濂旂徊?`docs +update` 闁告瑯鍨禍鎺楀棘閺夎法绱︾紒宀冩濞呇囨偨缂佹ɑ绶?*
### 闁革妇鍎ゅ▍?1闁挎稒鑹鹃崙锟犳焻濮樺磭绠?docs +fetch 闁兼儳鍢茶ぐ鍥礆閻楀牊鐎俊妤嬬到閸炲鈧湱鎳撻幏浼存偨缂佹ɑ绶?token
濠碘€冲€归悘澶愭偨閵婏箑鐓曠€规瓕灏欑划锟犳焻濮樺磭绠?`docs +fetch` 闁瑰嘲顦ぐ鍥ㄧ閸℃ɑ鐎俊妤嬬到閸炲鈧湱娅㈢槐婵嬬嵁閺堢數鐟柡鍌氭处閵嗗倹绋夐鐐插殥闁哄牆顦遍弫楣冨级閸栵紕绀勯弶鈺傛煥濞叉牠鎯?markdown 濞戞搩鍘肩€垫﹢宕?`<whiteboard token="xxx"/>` 闁哄秴娲ㄩ鐑芥晬婢舵稓绀夐悹鍥у槻缁扁晝鈧絻鍋愰弫銈夊箣閸戙倗绐?
1. 閻犱焦婢樼紞宥夋偨缂佹ɑ绶查柣?token
2. 闁哄被鍎冲﹢?[`../lark-whiteboard/SKILL.md`](../lark-whiteboard/SKILL.md) 濞存粌妫滆濠碘€冲€风紞宥囩磽閺嶎剛甯嗛柣銏㈢帛濠㈡﹢宕橀崨顓у晣
### 闁革妇鍎ゅ▍?2闁挎稒鑹鹃崹浼村礆濞戞绱﹂柣銏㈢帛濠㈡﹢鏁嶅畝鍕粯閻熸洑鑳剁槐顏呮綇?
濠碘€冲€归悘澶愭偨閵婏箑鐓曢柛鎺撳哺閳ь剚淇虹换?`docs +update` 闁告帗绋戠紓鎾寸閸℃瑢鏁勯柣褏鏅弫楣冨级閸栵紕绀夐梻鍥ｅ亾閻熸洑鑳剁槐顏呮綇閹寸偞顦ч柨?
**婵縿鍎甸?1闁挎稒纰嶇€垫粎绮氶搹瑙勵仱闁汇垻绮妯兼嫚椤撶喓銆婇柛鎺撶☉缂?*
- 闁?`--markdown` 濞戞搩鍘惧ú鍧楀箳閵夈倗鐐?`<whiteboard type="blank"></whiteboard>`
- 闂傚洠鍋撻悷鏇氱椤︽寧绋夐鍡忔晞闁谎呮櫕閺侀箖寮堕幐搴㈩槯闁挎稑鑻﹢顏堝触鐏炶偐顏卞☉?`--markdown` 闂佹彃鐭傞崳鍛婂緞瀹ュ拋妯嬪☉?whiteboard 闁哄秴娲ㄩ?
  **婵縿鍎甸?2闁挎稒鐭划鐘诲传瀹ュ懐瀹夊☉鎿冨弨椤斿洩銇?token**
- `docs +update` 闁瑰瓨鍔曟慨娑㈠触鎼搭垳绀夐悹鍥嚙瑜板洭宕鍛畨閻庢稒顨嗛?`data.board_tokens`
- `data.board_tokens` 闁哄嫷鍨遍弻濠傤嚈閾忚鏆伴柡澶庢硶濞?token 闁告帗顨夐妴鍐晬鐏炶姤鍊电紓渚囧幘缁鳖亝娼忛幋鐘崇函闁规亽鍎版繛鍥偨閵娿劎绠归梺鎻掔灱濞?token
  **婵縿鍎甸?3闁挎稒鑹剧槐鈺冣偓浣冨亹缁鳖亝娼?*
- 閻犱焦婢樼紞宥夋閳ь剛鎲版担铏规そ閺夊牊鍨瑰▓鎴︽偨缂佹ɑ绶?token
- 闁哄被鍎冲﹢?[`../lark-whiteboard/SKILL.md`](../lark-whiteboard/SKILL.md) 濞存粌妫滆濠碘€冲€风紞宥囩磽閺嶎剛甯嗛柣銏㈢帛濠㈡﹢宕橀崨顓у晣
### 婵炲鍔嶉崜鐗堢鐎ｎ喓鈧?
- 鐎圭寮跺﹢渚€鎮界紒妯荤凡闁告劕鎳庨鎰板籍閻樺磭銆婇梺顐ｄ亢缁?lark-doc 闁?`docs +update` 闁烩晛鐡ㄧ敮瀵哥磽閺嶎剛甯?
- 缂傚倹鐗炵欢顐︽偨缂佹ɑ绶查梻鍥ｅ亾閻熸洑妞掓繛鍥偨閵娿倗鐟╅梻鍌樺妿濞?[`../lark-whiteboard/SKILL.md`](../lark-whiteboard/SKILL.md)

## 闊浂鍋婇埀顒傚枎閸犲懐绮?
- 闁活潿鍔嶉崺娑氭嫚缁厜鍋撳鍕棟濞戞挴鍋撳☉鎿冧海閵嗗啴寮界亸鏍ゅ亾濠靛啠鍋撳鍕樆闁告艾绉惰ⅷ闁瑰吋绮庨弫鍝モ偓娑欏姌閵嗗啴寮界亸鏍ゅ亾濠靛啠鍋撳鍕棟闁硅翰鍎撮妴鍐灳濠靛啠鍋撳鍕粯閺夆晜鍨舵晶锕€顕ｉ埀顒勬儍閸曨喓鈧啴寮界亸鏍ゅ亾濠垫挾绀夐柛蹇撶墢閺?`lark-cli docs +search` 闁稿淇虹粊顐⑩攦閹邦剙绲洪柣婊嗗焽閳?
- `docs +search` 濞戞挸绉靛Σ鎼佸矗椤忓懏鍋濋柡鍌氭处閵?/ Wiki闁挎稒绋撶划銊╁几濠婂牆娅″ù鍏兼皑濞插潡骞掗妷銊х闁?`SHEET` 缂佹稑顦花顖滅矚濞差亝锛熼悗鐢殿攰閽栧嫰濡?
- 闁瑰嘲鐏濋崺?spreadsheet URL / token 闁告艾鍑界槐婵嬪礃瀹ュ懎鐎奸柛?`lark-sheets` 闁稿鑹鹃顔炬寬閳ュ啿鏁堕梺顔哄姀椤曚即宕ｉ弽銉㈠亾娴ｈ櫣鎽ｉ梺顐㈩槶閳ь兛绀侀崯鎾诲礂閵壯呮惣闁瑰灝绉崇紞鏃堝Υ?

## 閻炴稏鍎遍崢鏍嫚鐎涙ɑ顫?
`docs +search` 闂傚嫨鍊撶花锟犲箹濠婂懎鍋嶉柡鍌氭处閵?/ Wiki闁挎稑濂旂弧鍐箥閹稿骸顎撻柍銉︾矊閸樻稓鈧鐭紞鍛閹寸姭鏁勯梻鍌涙綑椤曨喚鎸掗埥鍛闁告劕绉撮崹蹇涘炊閻愬樊鍤犻幖瀛樻煣缁楃喖宕?skill 闁瑰灝绉崇紞鏃堝灳濠靛牊鐣遍悹褍瀚花顕€宕ｉ幋鐘茬疀闁稿繈鍎辫ぐ娑氭喆閹烘洖顥忛柨娑欑☉缂嶅鎮介妸锕€鐓曢柛娆欑到閵囨梻鎷犵划鍏夊亾濠婂棎鈧啴寮?/ 闁硅翰鍎撮妴鍐灳濠靛洦顦ч柨娑樺缁″啯瀵煎Ο鍝勫弗濞寸姴姘︾换鏍煂鐏炵晫纾诲┑顔碱儍閳?

## Shortcuts闁挎稑鐗婄敮褰掓嚒閹邦亞鍠橀柛蹇撶墔婵炲洭鎮介…鎺旂

Shortcut 闁哄嫷鍨伴顔炬暜閸濄儲鏆忛柟鍨С缂嶆棃鎯冮崟顖滃蒋缂佺嫏鍐閻熶礁鎷戠槐妾俵ark-cli docs +<verb> [flags]`闁挎稑顦埀顒€鍊瑰﹢?Shortcut 闁汇劌瀚幖閿嬫媴濠娾偓缁鳖參宕楅崼婊冣枏闁活潿鍔婇埀?

| Shortcut | 閻犲洤鐡ㄥΣ?|
|----------|------|
| [`+search`](references/lark-doc-search.md) | Search Lark docs, Wiki, and spreadsheet files (Search v2: doc_wiki/search) |
| [`+create`](references/lark-doc-create.md) | Create a Lark document |
| [`+fetch`](references/lark-doc-fetch.md) | Fetch Lark document content |
| [`+update`](references/lark-doc-update.md) | Update a Lark document |
| [`+media-insert`](references/lark-doc-media-insert.md) | Insert a local image or file at the end of a Lark document (4-step orchestration + auto-rollback) |
| [`+media-download`](references/lark-doc-media-download.md) | Download document media or whiteboard thumbnail (auto-detects extension) |
| [`+whiteboard-update`](references/lark-doc-whiteboard-update.md) | Update an existing whiteboard in lark document with whiteboard dsl. Such DSL input from stdin. refer to lark-whiteboard skill for more details. |

