---
name: lark-openapi-explorer
description: Use when existing lark-* skills or registered lark-cli commands cannot satisfy a request and native Feishu/Lark OpenAPI discovery is required.
metadata:
  requires:
    bins: ["lark-cli"]
---

# OpenAPI Explorer

> **闁告挸绉堕悿鍡涘级閳ュ弶顐介柨?* 闁稿繐鐗撳Σ鍕嫚?[`../lark-shared/SKILL.md`](../lark-shared/SKILL.md) 濞存粌妫滆閻犱降鍊涢惁澶愬Υ娴ｄ粙鐓╁ù鐘烘閸ㄥ繘骞戦姀鐘冲閻庣懓顦崣蹇曟喆閸曨偄鐏熼柕?

鐟滅増鎸鹃弫銈夊箣妞嬪孩鐣遍梻鍥ｅ亾婵?*闁哄啰濮电涵鍓佹偖椤愩倕绠涢柡?skill 闁?CLI 鐎圭寮堕弫鐐哄礃?API 閻熸洖妫涘ú?*闁哄啳顔愮槐婵囨媴鐠恒劍鏆忛柡鍫墯婵⊙囨嚄閹存帞鐭ゅ瀣仒閸旂喓鈧蓱閺?markdown 闁哄倸娲﹂妴鍌涙償閹捐尪鍘梺顐ｅ姇閻即骞愰弽銊ユ丢闁告鍠撻弫?OpenAPI 闁规亽鍎辫ぐ娑㈡晬瀹€鈧崝褔宕ユ惔銊㈠亾濮樺磭绠?`lark-cli api` 閻熶焦鐡曢惃鐔衡偓鐟版湰閸ㄦ碍绂掔拠鎻掝潳闁?


## Execution-Focused Rule

This skill should optimize for correct API discovery and execution. The AI should narrow quickly to the most likely module and only fall back to raw OpenAPI when existing lark-cli abilities are clearly insufficient.

When guiding execution, make sure the result clearly states:
- whether an existing `lark-*` skill or registered CLI command already covers the task
- which module or document should be opened first when raw OpenAPI is needed
- which exact API path or `lark-cli api` call should be tried next
- which assumption must be verified before executing the API call

## 闁哄倸娲﹂妴鍌涙償閹惧墎娉㈤柡?

濡炲鍋橀崝?OpenAPI 闁哄倸娲﹂妴鍌涚?markdown 閻忕偛鍊绘鍥╃磼閸曨厾鐭忛柨?

```
llms.txt                          闁?濡炪倛娉涢惇鎵閵忕姷绌块柨娑樿嫰閸亪宕欓悜妯侯暡闁哄牆顦拌啯闁秆勵殕閺嬪啫顩奸敐澶嬫嚑闁?
  闁宠鏌￠弨?llms-<module>.txt            闁?婵☆垪鈧櫕鍋ラ柡鍌氭处閵嗗倿鏁嶇仦钘夌樁闁告凹鍋勬慨娑㈡嚄閼恒儺娲ら弶?+ 閹煎瓨娲栭惇?API 闁哄倸娲﹂妴鍌炴煣閻愵剙澶?
       闁宠鏌￠弨?<api-doc>.md            闁?闁告娲戦柌?API 闁汇劌瀚悾顒勫极绾惧鍤涢柡鍕嚱缁辨瑩寮憴鍕€?閻犱警鍨扮欢?闁告瑥鍊归弳?闁告繂绉寸花?闂佹寧鐟ㄩ銈夋儘娓氬﹦绀?
```

闁哄倸娲﹂妴鍌炲礂閵夈儱缍撻柨?

| 闁告繀鑳舵晶?| 闁稿繈鍎辫ぐ?URL |
|------|----------|
| 濡炲鍋橀崝?(Feishu) | `https://open.feishu.cn/llms.txt` |
| Lark | `https://open.larksuite.com/llms.txt` |

> 闁圭鍋撻柡鍫濐槹閺嬪啫顩奸敐鍕鞍**濞戞搩鍘介弸?*缂傚倹鐗曢崯鎾诲Υ閸屾凹娲ら柡瀣矌閺併倝骞嬮摎鍌氣枏闁活潿鍔忕€氭娊寮崶锔藉攭婵炵繝绶ょ槐婵嬫閳ь剛浜搁崱妯荤€俊妤嬬到閸炲鈧懓婀遍悙鏇犳嫚閹存粏绀嬮柤鏄忛哺閺嬪啴宕ユ惔銈囩炕闁告垶浜介埀?

## 闁瑰憡鐗楃敮銏犆规担琛℃煠

濞戞挶鍎查悧鎼佸箰婢跺绨板☉鎾愁儐椤掔偞顨ラ妶澶嗗亾閹邦剛婀存俊顐熷亾缂侀硸婢佺槐?*濞戞挸绉烽々锔炬崉閾忣偒鍔勯柟瀛樼墱鐎佃棄霉?API**闁?

### Step 1闁挎稒姘ㄩ垾妯兼媼閵堝洤绠涢柡鍫濐槼閸忔﹢宕濆☉妤冪憹閻?

```bash
# 闁稿繐鐗婇ˉ鍛村蓟閵夛附笑闁告熬绠戦崙锟犲嫉婢跺鍤犻幖瀛樻⒒濞?skill 闁瑰瓨鐗曢崙鈥斥枖閵娿儱鏂€ API
lark-cli <闁告瑯鍨甸崗姗€鎯冮崜鍞€rvice> --help
```

濠碘€冲€归悘澶婎啅閸欏绠掗悗鐢垫嚀缁ㄦ煡宕ㄩ幋鎺撳Б闁?shortcut闁挎稑鐬煎ú鍧楀箳閵夈倕鈻忛柣銏╃厜缁?*濞戞挸绉瑰〒鍓佹啺娴ｇ儤鍩涚紓渚囧幗鐎垫煡骞?*闁?

### Step 2闁挎稒鐭划鐘炽亜鐠鸿櫣婀寸紒渚垮灩缁扁晝鈧鐭紞鍛熼垾铏仴

闁?WebFetch 闁兼儳鍢茶ぐ鍥ㄣ亜鐠鸿櫣婀寸紒渚垮灩缁扁晠鏁嶇仦鎯ь棟闁告帡顣︾粭宀勬閳ь剙效閸屾粍绁查柛蹇撶－濞堟垵螣閳ヨ櫕鍋ラ柡鍌氭处閵嗗倿鏌ч悙顒€澶嶉柨?

```
WebFetch https://open.feishu.cn/llms.txt
  闁?闁圭粯鍔曡ぐ鍥⒒椤曗偓椤ｄ粙鏁?闁告帗顨呴崵顓㈠箥閳ь剟寮垫径瀣嗕線宕稿Δ浣圭€俊妤嬬秮閹藉ジ骞掗妷顖滅闁瑰灚鍎抽崵顓熺▔?<闁活潿鍔嶉崺娑㈡閳ь剙效閸屾艾褰犻梺娆惧枦閻? 闁烩晝顭堥崣褔鎯冮崟顖涙嚑闁?
```

- 濡炲鍋橀崝鐔煎传娴ｅ搫顤傚ù锝堟硶閺?`open.feishu.cn`
- Lark 闁告繀鑳舵晶婵囨媴鐠恒劍鏆?`open.larksuite.com`
- 濠碘€冲€风粭澶屾兜椤旇偐鏆伴柣顫妽閸╂盯宕担鍝勵杺闁挎稑鐭傜划顖滄媼閵堝嫬鈻忛柣顫姂椤ワ絾绋?

### Step 3闁挎稒鐭划鐘参熼垾铏仴闁哄倸娲﹂妴鍌溾偓瑙勭煯缂嶅懘宕楅摎鍌滅Ъ API

闁?WebFetch 闁兼儳鍢茶ぐ鍥熼垾铏仴闁哄倸娲﹂妴鍌炴晬鐏炴儳顥濋柛鎺撴緲閸欐寧鎷?API 闁汇劌瀚弸鍐浖閿濆鎳犻柟鎭掑劵缁?

```
WebFetch https://open.feishu.cn/llms-docs/zh-CN/llms-<module>.txt
  闁?闁圭粯鍔曡ぐ鍥⒒椤曗偓椤ｄ粙鏁?闁瑰灚鍎抽崵顓熺▔?<闁活潿鍔嶉崺娑㈡閳ь剙效? 闁烩晝顭堥崣褔鎯?API 閻犲洤鐡ㄥΣ鎴﹀椽鐏炵偓鐎俊妤嬬秮閹藉ジ骞?
```

### Step 4闁挎稒淇洪獮蹇涘矗?API 閻庣懓鏈弳锝囨喆閸曨喖鐦?

闁?WebFetch 闁兼儳鍢茶ぐ鍥礂閾氬倻绉?API 闁哄倸娲﹂妴鍌炴晬鐏炴儳绲归柛娆愮墪閻ｎ剟寮€靛憡鐣遍悹瀣暟閺併倗鎲撮崟顔肩槺闁?

```
WebFetch https://open.feishu.cn/document/server-docs/.../<api>.md
  闁?闁圭粯鍔曡ぐ鍥⒒椤曗偓椤ｄ粙鏁?閺夆晜鏌ㄥú鏍偓鐟版湰閺?API 閻熸瑥瀚€垫牠鏁嶅▎绫楾P 闁哄倽顫夌涵鍫曞Υ娑斾阜L 閻犱警鍨扮欢鐐哄Υ娴ｇ晫鐔呯€垫澘瀚顒勫极閼割兘鍋撴担鍦弨閻犲洢鍨瑰顒勫极閼割兘鍋撴担绛嬪殲婵懓鍊风紞瀣偓娑欘殕椤斿矂鏁嶉崼婵囧€崇紒?缂侇偉顕ч悗?闊洤鎳庨敐?閻犲洤鐡ㄥΣ鎴︽晬婢跺牃鍋撴担鍛婃儥閹煎瓨鏌ㄩ悺褍鈻撻悙鍏夊亾娴ｇ懓顣查梻鍥ｅ亾闁哄鍟村娲Υ娓氣偓閺佸﹦鎷犻婊呭灣"
```

### Step 5闁挎稒宀搁埀顒佷亢缁?CLI 閻犲鍟伴弫?API

濞达綀娉曢弫?`lark-cli api` 閻熶焦鐡曢惃鐔兼晬?

```bash
# GET 閻犲洭鏀遍惇?
lark-cli api GET /open-apis/<path> --params '{"key":"value"}'

# POST 閻犲洭鏀遍惇?
lark-cli api POST /open-apis/<path> --data '{"key":"value"}'

# PUT 閻犲洭鏀遍惇?
lark-cli api PUT /open-apis/<path> --data '{"key":"value"}'

# DELETE 閻犲洭鏀遍惇?
lark-cli api DELETE /open-apis/<path>
```

## 閺夊牊鎸搁崵顓犳喆閸曨喖鐦?

闁告碍鍨归弫銈夊箣瀹勭増鍟涢柣婊呭鐎垫煡骞掑Ο鑲╂尝闁哄绮嶅鍌炴晬鐏炴儳鐦诲ù鐘劙缁楀懘寮介悡搴ｇ缂備礁瀚划鎰版晬?

1. **API 闁告艾绉惰ⅷ濞戞挸楠告慨娑㈡嚄?*闁挎稒鐭粩鎾矗閵夈劎妯堥柟璇茬箺閸?
2. **HTTP 闁哄倽顫夌涵鑸电▔鎼淬倗鐔呯€?*闁挎稒鐡狹ETHOD /open-apis/...`
3. **闁稿繑濞婇弫顓㈠矗閸屾稒娈?*闁挎稒鑹鹃崹顏堝礄閸濆嫮绠戝┑澶樺亜閹锋壆鏁崫銉︽殢闁告瑯鍨堕埀顒€顦顒勫极?
4. **闁圭鍋撻梻鍥ｅ亾闁哄鍟村?*闁挎稒顒璫ope 闁告帗顨夐妴?
5. **閻犲鍟伴弫銈囩矆鏉炴壆浼?*闁挎稒姘ㄧ划浼村礄?`lark-cli api` 闁汇劌瀚悾顒勫极閺夋垶鍤掑ù?
6. **婵炲鍔嶉崜鐗堢鐎ｎ喓鈧?*闁挎稒宀搁。鍫曟偝閸ヮ剚顎欓柛鎺曠堪閳ь兛鑳舵竟鎺戔枔婵犲嫬顔婇柡澶屽枔閻?

濠碘€冲€归悘澶愭偨閵婏箑鐓曞ù锝堟硶閺併倝鎳熸潏銊︾€ù婧垮€栫粊锕傛晬鐏炵晫娈哄ù鐘劙缁楀倿骞嶉埀顒勫嫉婢跺﹤鏁堕悗鐟版贡閻愭洜鎷犻幋婊嗙闁兼槒椴搁弸鍐Υ?

## 閻庣懓顦崣蹇曟喆閸曨偄鐏?

- **闁告劖鐟ラ崣?闁告帞濞€濞呭海鐚?API**闁挎稑婀ST/PUT/DELETE闁挎稑顦抽惃鐔兼偨閵娿儱顤呴煫鍥ф嚇閵嗗繒娑甸娆惧悋闁活潿鍔嶉崺娑㈠箛韫囨挻绂?
- 鐎点倝缂氶鍛村礂閸垺鏆?`--dry-run` 濡澘瀚～宥囨嫚闁垮婀撮柨娑樼墕椤┭囧绩椤栨稑鐦柨?
- 濞戞挸绉烽々锕傛偖濠婂嫮銈?API 閻犱警鍨扮欢鐐哄箣閺嵮冩闁轰焦澹嬮埀顒佹煛閳ь剚鏌ㄧ换鈧銈堫唺缁娀寮崶銊ｂ偓鍌涚▔椤撯€崇闁告瑦鐗滈垾妯兼媼?
- 婵炴垵顦鐑藉极韫囨柨濡抽柟鍨С缂嶆棃鏁嶉崼婵嗙仼闂傚嫨鍊楅崗銏ゅΥ娴ｇ洅鈺呮⒔閵堝棗鐏囬柛娑欘焽閻℃垿鏁嶆径瀣槯闁挎稑鑻幃婊堟偨閵婏箑鐓曢悹鍥х摠濡叉垼銇愰崡鐐存儥闁肩厧鍟ú?

## 濞达綀娉曢弫銈夊捶閻戞ɑ鐝紒鈧潪鎵紣

### 闁革妇鍎ゅ▍?1闁挎稒姘ㄩ弫銈夊箣閻戣姤浠橀悷鏇氱劍婵儤绂嶆ウ璺ㄧ缂傚洢鍊х槐娆撳嫉椤忓浂娼?CLI 閻忓繋娴囬ˉ濠囨晬?

```bash
# Step 1: 缁绢収鍠涢?CLI 婵炲备鍓濆﹢浣轰焊娴ｇ瓔妫?
lark-cli im --help
# 闁?闁告瑦鍨归獮鍥р柦閳╁啯绠?chat_members 闁烩晝顭堥崣褔鎯?create 闁告稒鍨濋幎?

# Step 2-4: 闂侇偅淇虹换鍐棘閸ャ劊鈧倿骞愰弽銊ユ丢闁兼儳鍢茬欢?API 閻熸瑥瀚€?
# 闁?POST /open-apis/im/v1/chats/:chat_id/members

# Step 5: 閻犲鍟伴弫?
lark-cli api POST /open-apis/im/v1/chats/oc_xxx/members \
  --data '{"id_list":["ou_xxx","ou_yyy"]}' \
  --params '{"member_id_type":"open_id"}'
```

### 闁革妇鍎ゅ▍?2闁挎稒姘ㄩ弫銈夊箣閻戣姤浠橀悷鏇氭祰椤旀洜绱旈鎯у弮闁稿浚鍓欓幉?

```bash
# Step 1: 缁绢収鍠涢?CLI 婵炲备鍓濆﹢浣轰焊娴ｇ瓔妫?
lark-cli im --help
# 闁?婵炲备鍓濆﹢?announcement 闁烩晝顭堥崣褔宕ㄩ幋鎺撳Б

# Step 2-4: 闁瑰憡鐗楃敮銏ゅ棘閸ャ劊鈧?
# 闁?PATCH /open-apis/im/v1/chats/:chat_id/announcement

# Step 5: 閻犲鍟伴弫?
lark-cli api PATCH /open-apis/im/v1/chats/oc_xxx/announcement \
  --data '{"revision":"0","requests":["<html>闁稿浚鍓欓幉锟犲礃閸涱収鍟?/html>"]}'
```

## 闁告瑥鍊介埀?

- [lark-shared](../lark-shared/SKILL.md) 闁?閻犱降鍊涢惁澶愬椽鐏炶棄寮块悘鐐╁亾闁告瑥鍊归弳?
- [lark-skill-maker](../lark-skill-maker/SKILL.md) 闁?濠碘€冲€垮〒鍓佷焊閸℃ê顕ч柟鐑樏崺宀勬儍?API 闁搞儱鎼€靛弶绋夐悜妯荤厐 Skill
