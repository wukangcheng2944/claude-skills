---
name: lark-base
description: Use when operating Feishu/Lark Base through lark-cli for table, field, record, view, formula, lookup, and data-query workflows.
metadata:
  requires:
    bins: ["lark-cli"]
  cliHelp: "lark-cli base --help"
---

# base

> **閸撳秶鐤嗛弶鈥叉閿?* 閸忓牓妲勭拠?[`../lark-shared/SKILL.md`](../lark-shared/SKILL.md)閵?
> **閹笛嗩攽閸撳秴绻€閸嬫熬绱?* 閹笛嗩攽娴犺缍?`base` 閸涙垝鎶ら崜宥忕礉韫囧懘銆忛崗鍫ユ鐠囪顕惔鏂挎嚒娴犮倗娈?reference 閺傚洦銆傞敍灞藉晙鐠嬪啰鏁ら崨鎴掓姢閵?
> **閸涜棄鎮曠痪锕€鐣鹃敍?* 娴犲懍濞囬悽?`lark-cli base +...` 瑜般垹绱￠惃鍕嚒娴犮們鈧?


## Agent-First Output Rule

`base` outputs must narrow failures to the smallest table, field, view, formula, lookup, or record boundary instead of reporting a generic Base error.

Always make these explicit:
- `suspected_scope`: the most relevant table, field, view, formula, lookup, or record
- `strongest_evidence`: the key schema result, write rejection, empty response, or command error
- `next_best_action`: the single best next inspection or verification step
- `next_target`: the exact `table_id`, `field_id`, command, or reference doc to inspect next
- `confidence`: high, medium, or low

## Agent 韫囶偊鈧喐澧界悰宀勩€庢惔?

1. **閸忓牆鍨介弬顓濇崲閸旓紕琚崹?*
   - 娑撳瓨妞傜紒鐔活吀 / 閼辨艾鎮庨崚鍡樼€?閳?`+data-query`
   - 鐟曚焦濡哥紒鎾寸亯闂€鎸庢埂閺勫墽銇氶崷銊ㄣ€冮柌?閳?formula 鐎涙顔?
   - 閻劍鍩涢弰搴ｂ€樼憰?lookup閿涘本鍨ㄧ涵顔肩杽閺囨挳鈧倸鎮?`from/select/where/aggregate` 閳?lookup 鐎涙顔?
   - 閺勫海绮忕拠璇插絿 / 鐎电厧鍤?閳?`+record-list / +record-get`
2. **閸忓牊瀣佺紒鎾寸€敍灞藉晙閸愭瑥鎳℃禒?*
   - 閼峰啿鐨崗鍫熷瑏瑜版挸澧犵悰銊х波閺嬪嫸绱癭+field-list` 閹?`+table-get`
   - 鐠恒劏銆冮崷鐑樻珯韫囧懘銆忛崘宥嗙叀**閻╊喗鐖ｇ悰?*閻ㄥ嫮绮ㄩ弸?
3. **formula / lookup 閺堝鈥栭梻銊︻潬**
   - 閸忓牐顕扮€电懓绨?guide
   - 鐠囪鐣?guide 閸氬函绱濋崘宥呭灡瀵ゅ搫顕惔鏂跨摟濞?
4. **閸愭瑨顔囪ぐ鏇炲閸忓牆鍨介弬顓炵摟濞堥潧褰查崘娆愨偓?*
   - 閸欘亜鍟撶€涙ê鍋嶇€涙顔?
   - 缁崵绮虹€涙顔?/ formula / lookup 姒涙顓婚崣顏囶嚢

## Agent 缁備焦顒涚悰灞艰礋

- 娑撳秷顩﹂幎?`+record-list` 瑜版捁浠涢崥鍫濆瀻閺嬫劕绱╅幙?
- 娑撳秷顩﹀▽陇顕?guide 鐏忚京娲块幒銉ュ灡瀵?formula / lookup 鐎涙顔?
- 娑撳秷顩﹂崙顓″殰閻掓儼顕㈢懛鈧悮婊嗐€冮崥宥冣偓浣哥摟濞堥潧鎮曢妴浣稿彆瀵繗銆冩潏鎯х础闁插瞼娈戠€涙顔屽鏇犳暏
- 娑撳秷顩﹂幎濠勯兇缂佺喎鐡у▓鐐光偓涔玱rmula 鐎涙顔岄妴涔磑okup 鐎涙顔岃ぐ鎾村灇 `+record-upsert` 閻ㄥ嫬鍟撻崗銉ф窗閺?
- 娑撳秷顩﹂崷?Base 閸︾儤娅欓弨纭呰泲 `lark-cli api GET /open-apis/bitable/v1/...`
- 娑撳秷顩﹂崶鐘辫礋 wiki 鐟欙絾鐎界紒鎾寸亯闁插瞼娈?`obj_type=bitable` 鐏忓崬骞撻幍?`bitable.*`閿涙稑婀張?CLI 闁插苯绨茬紒褏鐢绘担璺ㄦ暏 `lark-cli base +...`

## Base 閸╃儤婀拌箛鍐╂濡€崇€?

1. **Base 鐎涙顔岄崚鍡曠瑏缁?*
   - **鐎涙ê鍋嶇€涙顔?*閿涙氨婀＄€圭偛鐡ㄩ悽銊﹀煕鏉堟挸鍙嗛惃鍕殶閹诡噯绱濋柅姘埗闁倸鎮?`+record-upsert` 閸愭瑥鍙嗛敍灞肩伐婵″倹鏋冮張顑锯偓浣规殶鐎涙ぜ鈧焦妫╅張鐔粹偓浣稿礋闁鈧礁顦块柅澶堚偓浣锋眽閸涙ǜ鈧礁鍙ч懕鏂烩偓?*闂勫嫪娆㈢€涙顔屾笟瀣樆**閿涙艾顕?agent 閼板矁鈻堥敍灞炬瀮娴犳湹绗傛导鐘茬箑妞ゆ槒铔?`+record-upload-attachment`閵?
   - **缁崵绮虹€涙顔?*閿涙艾閽╅崣鎷屽殰閸斻劎娣幎銈忕礉閸欘亣顕伴敍灞藉悁閸ㄥ瀵橀幏顒€鍨卞鐑樻闂傛番鈧焦娓堕崥搴㈡纯閺傜増妞傞梻娣偓浣稿灡瀵よ桨姹夐妴浣锋叏閺€閫涙眽閵嗕浇鍤滈崝銊х椽閸欐灚鈧?
   - **鐠侊紕鐣荤€涙顔?*閿涙岸鈧俺绻冪悰銊ㄦ彧瀵繑鍨ㄧ捄銊ㄣ€冪憴鍕灟閹恒劌顕遍敍灞藉涧鐠囦紮绱濋崗绋跨€烽崠鍛 **閸忣剙绱＄€涙顔岄敍鍧抩rmula閿?* 閸?**閺屻儲澹樺鏇犳暏鐎涙顔岄敍鍧檕okup閿?*閵?
2. **閸愭瑨顔囪ぐ鏇炲閸忓牆鍨介弬顓炵摟濞堢數琚崚?* 閳?閸欘亝婀佺€涙ê鍋嶇€涙顔岄崣顖滄纯閹恒儱鍟撻敍娑樺彆瀵?/ lookup / 閸掓稑缂撻弮鍫曟？ / 閺囧瓨鏌婇弮鍫曟？ / 閸掓稑缂撴禍?/ 娣囶喗鏁兼禍?/ 閼奉亜濮╃紓鏍у娇闁棄绨茬憴鍡曡礋閸欘亣顕版潏鎾冲毉鐎涙顔岄敍灞肩瑝閼宠姤瀣侀弶銉ヤ粵 `+record-upsert` 閸忋儱寮妴?
3. **Base 娑撳秴褰ч弰顖氱摠鐞涖劍鏆熼幑顕嗙礉娑旂喕鍏橀崘鍛紦鐠侊紕鐣?* 閳?閻劍鍩涢幓鎰毉閳ユ粎绮虹拋掳鈧焦鐦潏鍐︹偓浣瑰笓閸氬秲鈧焦鏋冮張顒佸閹恒儯鈧焦妫╅張鐔锋▕閵嗕浇娉曠悰銊︾湽閹眹鈧胶濮搁幀浣稿灲閺傤厸鈧繄鐡戦棁鈧Ч鍌涙閿涘奔绗夐懗浠嬬帛鐠併倕顕遍崙鐑樻殶閹诡喖鎮楅幍瀣暬閿涙稖顩﹂崗鍫濆灲閺傤厽妲搁崥锕€绨查柅姘崇箖 `+data-query` 閹存牕鍙曞蹇撶摟濞堥潧婀?Base 閸愬懎鐣幋鎰┾偓?

## 閸掑棙鐎界捄顖氱窞閸愬磭鐡?

1. **娑撯偓濞嗏剝鈧冨瀻閺?/ 娑撳瓨妞傞弻銉嚄** 閳?娴兼ê鍘?`+data-query`
   - 闁倸鎮庨敍姘瀻缂佸嫮绮虹拋掳鈧讣UM / AVG / COUNT / MAX / MIN閵嗕焦娼禒鍓佺摣闁鎮楅懕姘値閵?
   - 閻楃懓绶涢敍姘愁洣閻ㄥ嫭妲搁垾婊嗙箹濞嗭紕鐣婚崙鐑樻降閻ㄥ嫮绮ㄩ弸婧锯偓婵撶礉娑撳秵妲搁幎濠勭波閺嬫粍鐭囧ǎ鈧幋鎰€冮崘鍛摟濞堢偣鈧?
2. **闂€鎸庢埂婢跺秶鏁ら惃鍕烦閻㈢喐瀵氶弽?/ 鐞涘瞼楠囩拋锛勭暬缂佹挻鐏?* 閳?娴兼ê鍘涢崗顒€绱＄€涙顔?
   - 闁倸鎮庨敍姘焺濞戯妇宸奸妴浣规Ц閸氾箑娆㈤張鐔粹偓浣稿⒖娴ｆ瑥銇夐弫鑸偓浣稿瀻濡楋絾鐖ｇ粵淇扁偓浣芥硶鐞涖劍鐪归幀璇叉倵閻ㄥ嫭娣抽悽鐔虹波閺嬫嚎鈧?
   - 閻楃懓绶涢敍姘愁洣閹跺﹦绮ㄩ弸婊堟毐閺堢喐妯夌粈鍝勬躬 Base 闁插矉绱濈捄鐔兼鐠佹澘缍嶉懛顏勫З閺囧瓨鏌婇妴?
3. **閺勬儳绱＄憰浣圭湴 Lookup閿涘本鍨ㄧ涵顔肩杽鐟曚焦瀵?source/select/where/aggregate 瀵ょ儤膩** 閳?閻?lookup 鐎涙顔?
   - 姒涙顓绘禒宥勭喘閸忓牐鈧啳妾?formula閵嗕康ookup 閸欘亜婀悽銊﹀煕閺勫海鈥樼憰浣圭湴閵嗕焦鍨ㄩ弴瀵割儊閸氬牆娴愮€规碍鐓￠幍楣冨帳缂冾喗妞傛担璺ㄦ暏閵?
4. **閸樼喎顫愮拋鏉跨秿鐠囪褰?/ 閺勫海绮忕€电厧鍤?* 閳?`+record-list / +record-get`
   - 娑撳秷顩﹂幎?`+record-list` 瑜版挸鍨庨弸鎰穿閹垮函绱辩€瑰啳绀嬬拹锝呭絿閺勫海绮忛敍灞肩瑝鐠愮喕鐭楅懕姘値鐠侊紕鐣婚妴?

## 閸忣剙绱?/ Lookup 娑撴捇銆嶇憴鍕灟

1. **濞戝寮?formula / lookup 閺冭绱濋崗鍫ｎ嚢 guide閿涘苯鍟€閸戝搫鎳℃禒?*
   - formula閿涙瓟`formula-field-guide.md`](references/formula-field-guide.md)
   - lookup閿涙瓟`lookup-field-guide.md`](references/lookup-field-guide.md)
2. **guide 閸忓牅绨崚娑樼紦閸涙垝鎶?*
   - 濞屄ゎ嚢鐎电懓绨?guide 閸撳稄绱濇稉宥堫洣閻╁瓨甯撮崚娑樼紦 formula / lookup 鐎涙顔?
   - 鐠囪鐣?guide 閸氬函绱濋崘宥埶夋鎰嚠鎼?JSON 楠炶泛鍨卞鍝勭摟濞?
   - `type=formula` 韫囧懘銆忛幓鎰返 `expression`
   - `type=lookup` 韫囧懘銆忛幓鎰返 `from / select / where`閿涘苯绻€鐟曚焦妞傜悰?`aggregate`
3. **閸忣剙绱＄€涙顔屾导妯哄帥娴?lookup 鐎涙顔?*
   - 閸欘亣顩﹂悽銊﹀煕閻ㄥ嫯鐦斿Ч鍌涙Ц閳ユ粏顓哥粻?/ 閺夆€叉閸掋倖鏌?/ 閺傚洦婀版径鍕倞 / 閺冦儲婀″?/ 鐠恒劏銆冮懕姘値 / 鐠恒劏銆冪粵娑⑩偓澶婃倵閸欐牕鈧皷鈧繐绱濇妯款吇娴兼ê鍘涚亸婵婄槸 formula閵?
   - 閸欘亝婀侀悽銊﹀煕閺勫海鈥樼拠纾嬵洣 lookup閿涘本鍨ㄩ柊宥囩枂婢垛晝鍔ч弴鎾偓鍌氭値 lookup 閸ユ稑鍘撶紒鍕閿涘苯鍟€鐠?lookup閵?
4. **鐞涖劌鎮?/ 鐎涙顔岄崥宥呯箑妞よ崵绨跨涵顔煎爱闁?*
   - 閸忣剙绱￠妴涔磑okup閵嗕龚ata-query 娑擃厼鍤悳鎵畱鐞涖劌鎮?/ 鐎涙顔岄崥宥忕礉韫囧懘銆忛弶銉ㄥ殰 `+table-list` / `+table-get` / `+field-list` 閻ㄥ嫮婀＄€圭偠绻戦崶鐑囩礉缁備焦顒涢崙顓☆嚔娑斿瀵藉ù瀣暭閸愭瑣鈧?
5. **閸忓牊瀣佺紒鎾寸€崘宥呭晸鐞涖劏鎻?*
   - 閸忣剙绱￠幋?lookup 娑撯偓瀵板鍘涢懢宄板絿閻╃鍙х悰銊х波閺嬪嫸绱濋崘宥囨晸閹存劘銆冩潏鎯х础 / 闁板秶鐤嗛敍娑楃瑝鐟曚胶娲块幒銉ュ殶閻劍鍩涢崣锝堝牚閹风厧鐡у▓闈涙倳閵?

## Workflow 娑撴捇銆嶇憴鍕灟

1. **閹笛嗩攽娴犺缍?workflow 閸涙垝鎶ら崜宥忕礉韫囧懘銆忛崗鍫ｎ嚢娑撱倓鍞ら弬鍥ㄣ€傞敍姘嚠鎼存梻娈戦崨鎴掓姢閺傚洦銆?+ [lark-base-workflow-schema.md](references/lark-base-workflow-schema.md)**
   - `+workflow-create` 閳?閸忓牐顕?[lark-base-workflow-create.md](references/lark-base-workflow-create.md) + schema
   - `+workflow-update` 閳?閸忓牐顕?[lark-base-workflow-update.md](references/lark-base-workflow-update.md) + schema
   - `+workflow-list` 閳?閸忓牐顕?[lark-base-workflow-list.md](references/lark-base-workflow-list.md) + schema
   - `+workflow-get` 閳?閸忓牐顕?[lark-base-workflow-get.md](references/lark-base-workflow-get.md) + schema
   - `+workflow-enable` 閳?閸忓牐顕?[lark-base-workflow-enable.md](references/lark-base-workflow-enable.md) + schema
   - `+workflow-disable` 閳?閸忓牐顕?[lark-base-workflow-disable.md](references/lark-base-workflow-disable.md) + schema
   - schema 娑擃厼鐣炬稊澶夌啊閹碘偓閺?StepType 閺嬫矮濡囬妴浣诡劄妤犮倗绮ㄩ弸鍕┾偓涔€rigger/Action/Branch/Loop 閻?data 閺嶇厧绱￠妴浣糕偓鐓庣穿閻劏顕㈠▔鏇犵搼
   - 缁備焦顒涢崙顓″殰閻掓儼顕㈢懛鈧悮婊勭ゴ `type` 閸婄》绱欐俊鍌涘Ω"閺傛澘顤冪拋鏉跨秿"閻氭粍鍨?`CreateTrigger`閿涘绱濊箛鍛淬€忔禒?schema 閻?StepType 閺嬫矮濡囨稉顓烆槻閸掕泛鍣涵顔炬畱缁鐎烽崥宥囆?

2. **閸掓稑缂撻崜宥団€樼拋銈勭贩鐠ф牔淇婇幁?*
   - 閸忓牓鈧俺绻?`+table-list` / `+field-list` 閼惧嘲褰囬惇鐔风杽閻ㄥ嫯銆冮崥宥冣偓浣哥摟濞堥潧鎮?
   - 缁備焦顒涢崙顓″殰閻掓儼顕㈢懛鈧悮婊勭ゴ鐞涖劌鎮?鐎涙顔岄崥宥咃綖閸?workflow 闁板秶鐤?

## 閺嶇绺剧憴鍕灟

1. **閸欘亙濞囬悽銊ュ斧鐎涙劕鎳℃禒?* 閳?娴ｈ法鏁?`+table-list / +table-get / +field-create / +record-upsert / +view-set-filter / +record-history-list / +base-get` 鏉╂瑧琚稉鈧崨鎴掓姢娑撯偓閸斻劋缍旈惃鍕晸濞夋洩绱濇稉宥勫▏閻劍妫懕姘値瀵?`+table / +field / +record / +view / +history / +workspace`
2. **閸愭瑨顔囪ぐ鏇炲閸忓牐顕扮€涙顔岀紒鎾寸€?* 閳?閸忓牐鐨熼悽?`+field-list` 閼惧嘲褰囩€涙顔岀紒鎾寸€敍灞藉晙鐠?[lark-base-shortcut-record-value.md](references/lark-base-shortcut-record-value.md) 绾喛顓婚崥鍕摟濞堢數琚崹瀣畱閸愭瑥鍙嗛崐鍏肩壐瀵?
3. **閸愭瑥鐡у▓闈涘閸忓牏婀呯€涙顔岀仦鐐粹偓褑顫夐懠?* 閳?閸忓牐顕?[lark-base-shortcut-field-properties.md](references/lark-base-shortcut-field-properties.md) 绾喛顓?`+field-create/+field-update` 閻?JSON 缂佹挻鐎?
4. **缁涙盯鈧鐓＄拠銏″瘻鐟欏棗娴橀懗钘夊閹笛嗩攽** 閳?閸忓牐顕?[lark-base-view-set-filter.md](references/lark-base-view-set-filter.md) 閸?[lark-base-record-list.md](references/lark-base-record-list.md)閿涘矂鈧俺绻?`+view-set-filter` + `+record-list` 缂佸嫬鎮庣€瑰本鍨氱粵娑⑩偓澶庮嚢閸?
5. **鐎电顔囪ぐ鏇＄箻鐞涘苯鍨庨弸鎰剁礄濞戝寮?閺堚偓妤?閺堚偓娴?閹槒顓?楠炲啿娼?閹烘帒鎮?濮ｆ棁绶?閺佷即鍣?缁涘鍨庨弸鎰壈閸ユ拝绱?* 閳?閸忓牐顕?[lark-base-data-query.md](references/lark-base-data-query.md)閿涘矂鈧俺绻?`+data-query` 鏉╂稖顢戦弫鐗堝祦缁涙盯鈧浠涢崥鍫㈡畱閺堝秴濮熺粩顖濐吀缁?
6. **閼辨艾鎮庨崚鍡樼€芥稉搴″絿閺侀绨伴弬?* 閳?闂団偓鐟曚礁鍨庣紒鍕埠鐠?/ SUM / MAX / AVG / COUNT 閺冭绱濊箛鍛淬€忔担璺ㄦ暏 `+data-query`閿涘牊婀囬崝锛勵伂鐠侊紕鐣婚敍澶涚礉缁備焦顒涢悽?`+record-list` 閹峰鍙忛柌蹇氼唶瑜版洖鍟€閹靛濮╃拋锛勭暬閿涙稑寮芥稊瀣剁礉`+data-query` 娑撳秷绻戦崶鐐插斧婵顔囪ぐ鏇礉閸欐牗鏆熼崷鐑樻珯娴犲秷铔?`+record-list / +record-get`
7. **閹碘偓閺?`+xxx-list` 缁備焦顒涢獮璺哄絺鐠嬪啰鏁?* 閳?`+table-list / +field-list / +record-list / +view-list / +record-history-list / +role-list` 閸欘亣鍏樻稉鑼额攽閹笛嗩攽
8. **閹靛綊鍣烘稉濠囨 500 閺?濞?* 閳?閸氬奔绔寸悰銊ョ紦鐠侇喕瑕嗙悰灞藉晸閸忋儻绱濋獮璺烘躬閹佃顐奸梻鏉戞鏉?0.5閳? 缁?
9. **缂佺喍绔撮崣鍌涙殶閸?* 閳?娑撯偓瀵板濞囬悽?`--base-token`閿涘奔绗夋担璺ㄦ暏閺?`--app-token`
10. **闁洤鍩岄垾婊冨彆瀵?/ 閺屻儲澹樺鏇犳暏 / 濞插墽鏁撻幐鍥ㄧ垼 / 鐠恒劏銆冪拋锛勭暬閳ユ繈娓跺Ч鍌︾礉娴兼ê鍘涚挧鏉跨摟濞堝灚鏌熷鍫濆灲閺?* 閳?閸忓牆鍨介弬顓炵安瀵?formula / lookup 鐎涙顔岄敍宀冪箷閺勵垰褰ч崑姘濞嗏剝鈧?`+data-query`
11. **閸忣剙绱￠妴涔磑okup閵嗕胶閮寸紒鐔风摟濞堢敻绮拋銈堫潒娑撳搫褰х拠?* 閳?闂?`+field-create / +field-update` 缂佸瓨濮㈢€涙顔岀€规矮绠熸径鏍电礉娑撳秷顩﹂幎濠呯箹娴滄稑鐡у▓鍏哥稊娑撻缚顔囪ぐ鏇炲晸閸忋儳娲伴弽?
12. **閺€鐟版倳閸滃苯鍨归梽銈嗗瘻閺勫海鈥橀幇蹇撴禈閹笛嗩攽** 閳?`+view-rename` 閸︺劎娲伴弽鍥潒閸ユ儳鎷伴弬鏉挎倳缁変即鍏橀弰搴ｂ€橀弮璺哄讲閻╁瓨甯撮幍褑顢戦敍娌?record-delete / +field-delete / +table-delete` 閸︺劎鏁ら幋宄板嚒缂佸繑妲戠涵顔款洣濮瑰倸鍨归梽銈勭瑬閻╊喗鐖ｉ弰搴ｂ€橀弮鏈电瘍閸欘垳娲块幒銉﹀⒔鐞涘矉绱濇稉宥夋付鐟曚礁鍟€鐞涖儰绔村▎锛勨€樼拋銈忕礉楠炴湹绗栭幍褑顢戦崚鐘绘珟閸涙垝鎶ら弮鎯邦洣娑撹濮╃悰銉ょ瑐 `--yes`閿涙稑褰ч張澶屾窗閺嶅洣绗夐弰搴ｂ€橀弮鑸靛缂佈呯敾鏉╀粙妫?

## 闂傤喖宓?/ 鐞涖劌宕熼幓鎰仛

- **閼惧嘲褰囬梻顔煎祹閸掓銆?*閿涙矮濞囬悽?`+form-list`閿涘牆鍘涢幏?`form-id`閿?
- **閼惧嘲褰囬崡鏇氶嚋闂傤喖宓?*閿涙矮濞囬悽?`+form-get`
- **閼惧嘲褰囩悰銊ュ礋 / 闂傤喖宓庨梻顕€顣?*閿涙矮濞囬悽?`+form-questions-list`
- **閸掔娀娅庨梻顔煎祹 / 鐞涖劌宕熼梻顕€顣?*閿涙矮濞囬悽?`+form-questions-delete`
- **閸掓稑缂?/ 閺囧瓨鏌婇梻顕€顣?*閿涙矮濞囬悽?`+form-questions-create / +form-questions-update`

## 閹板繐娴?閳?閸涙垝鎶ょ槐銏犵穿

| 閹板繐娴?| 閹恒劏宕橀崨鎴掓姢 | 婢跺洦鏁?|
|------|---------|------|
| 閸掓銆?/ 閼惧嘲褰囬弫鐗堝祦鐞?| `lark-cli base +table-list` / `+table-get` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓稑缂?/ 閺囧瓨鏌?/ 閸掔娀娅庨弫鐗堝祦鐞?| `lark-cli base +table-create` / `+table-update` / `+table-delete` | 娑撯偓閸涙垝鎶ゆ稉鈧崝銊ょ稊 |
| 閸掓銆?/ 閼惧嘲褰囩€涙顔?| `lark-cli base +field-list` / `+field-get` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓稑缂?/ 閺囧瓨鏌婄€涙顔?| `lark-cli base +field-create` / `+field-update` | 娴ｈ法鏁?`--json` |
| 閸掓稑缂?/ 閺囧瓨鏌婇崗顒€绱＄€涙顔?| `lark-cli base +field-create` / `+field-update` | `type=formula`閿涙稑鍘涚拠?formula guide閿涘苯鍟€閸掓稑缂?/ 閺囧瓨鏌?|
| 閸掓稑缂?/ 閺囧瓨鏌?lookup 鐎涙顔?| `lark-cli base +field-create` / `+field-update` | `type=lookup`閿涙稑鍘涚拠?lookup guide閿涘苯鍟€閸掓稑缂?/ 閺囧瓨鏌婇敍宀勭帛鐠併倕鍘涢崚銈嗘焽 formula 閺勵垰鎯侀弴鏉戞値闁?|
| 閸掓銆?/ 閼惧嘲褰囩拋鏉跨秿 | `lark-cli base +record-list` / `+record-get` | 閸樼喎鐡欓崨鎴掓姢閿涘苯顩ч弸婊堟付鐟曚梗閼辨艾鎮庣拋锛勭暬`閿涘畭閸掑棛绮嶇紒鐔活吀` 閹恒劏宕樼挧?`+data-query` |
| 閸掓稑缂?/ 閺囧瓨鏌婄拋鏉跨秿 | `lark-cli base +record-upsert` | `--table-id [--record-id] --json` |
| 閼辨艾鎮庨崚鍡樼€?/ 濮ｆ棁绶濋幒鎺戠碍 / 濮瑰倹娓堕崐?/ 缁涙盯鈧绮虹拋?| `lark-cli base +data-query` | 娑撳秷顩﹂悽?`+record-list` 閹峰鍙忛柌蹇旀殶閹诡喖鍟€閹靛濮╃拋锛勭暬閿涘矂娓舵担璺ㄦ暏 `+data-query` 鐠х増婀囬崝锛勵伂鐠侊紕鐣?|
| 闁板秶鐤?/ 閺屻儴顕楃憴鍡楁禈 | `lark-cli base +view-*` | `list/get/create/delete/get-*/set-*/rename` |
| 閺屻儳婀呯拋鏉跨秿閸樺棗褰?| `lark-cli base +record-history-list` | 閹稿銆冮崪宀冾唶瑜版洘鐓＄拠銏犲綁閺囨潙宸婚崣?|
| 閹稿顫嬮崶鍓х摣闁鐓＄拠?| `lark-cli base +view-set-filter` + `lark-cli base +record-list` | 缂佸嫬鎮庣拫鍐暏 |
| 閸掓稑缂?/ 閼惧嘲褰?/ 婢跺秴鍩?Base | `lark-cli base +base-create` / `+base-get` / `+base-copy` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓銆?/ 閼惧嘲褰囧銉ょ稊濞?| `lark-cli base +workflow-list` / `+workflow-get` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓稑缂?/ 閺囧瓨鏌婂銉ょ稊濞?| `lark-cli base +workflow-create` / `+workflow-update` | 娴ｈ法鏁?`--json`閿涘苯绻€妞ゅ妲勭拠?schema |
| 閸氼垳鏁?/ 閸嬫粎鏁ゅ銉ょ稊濞?| `lark-cli base +workflow-enable` / `+workflow-disable` | 娑撯偓閸涙垝鎶ゆ稉鈧崝銊ょ稊 |
| 閸氼垳鏁?/ 閸嬫粎鏁ゆ妯奸獓閺夊啴妾?| `lark-cli base +advperm-enable` / `+advperm-disable` | 閸氼垳鏁ら崥搴㈠閼虫垝濞囬悽銊ㄥ殰鐎规矮绠熺憴鎺曞閿涙稑浠犻悽銊ょ窗娴ｅ灝鍑￠張澶庮潡閼规彃銇戦弫?|
| 閸掓銆?/ 閼惧嘲褰囩憴鎺曞 | `lark-cli base +role-list / +role-get` | 閺屻儳婀呯憴鎺曞閹芥顩﹂幋鏍х暚閺佹挳鍘ょ純?|
| 閸掓稑缂?/ 閺囧瓨鏌?/ 閸掔娀娅庣憴鎺曞 | `lark-cli base +role-create / +role-update / +role-delete` | 缁狅紕鎮婇懛顏勭暰娑斿顫楅懝鍙夋綀闂?|
| 閸掓銆?/ 閼惧嘲褰囩悰銊ュ礋 | `lark-cli base +form-list` / `+form-get` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓稑缂?/ 閺囧瓨鏌?/ 閸掔娀娅庣悰銊ュ礋 | `lark-cli base +form-create` / `+form-update` / `+form-delete` | 娑撯偓閸涙垝鎶ゆ稉鈧崝銊ょ稊 |
| 閸掓銆?/ 閸掓稑缂?/ 閺囧瓨鏌?/ 閸掔娀娅庣悰銊ュ礋闂傤噣顣?| `lark-cli base +form-questions-list` / `+form-questions-create` / `+form-questions-update` / `+form-questions-delete` | 娑撯偓閸涙垝鎶ゆ稉鈧崝銊ょ稊 |
| 閸掓銆?/ 閼惧嘲褰囨禒顏囥€冮惄?| `lark-cli base +dashboard-list` / `+dashboard-get` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓稑缂?/ 閺囧瓨鏌?/ 閸掔娀娅庢禒顏囥€冮惄?| `lark-cli base +dashboard-create` / `+dashboard-update` / `+dashboard-delete` | 娑撯偓閸涙垝鎶ゆ稉鈧崝銊ょ稊 |
| 閸掓銆?/ 閼惧嘲褰囨禒顏囥€冮惄?Block | `lark-cli base +dashboard-block-list` / `+dashboard-block-get` | 閸樼喎鐡欓崨鎴掓姢 |
| 閸掓稑缂?/ 閺囧瓨鏌?/ 閸掔娀娅庢禒顏囥€冮惄?Block | `lark-cli base +dashboard-block-create` / `+dashboard-block-update` / `+dashboard-block-delete` | 娑撯偓閸涙垝鎶ゆ稉鈧崝銊ょ稊 |


## 閹垮秳缍斿▔銊﹀壈娴滃銆?

- **Base token 閸欙絽绶炵紒鐔剁**閿涙氨绮烘稉鈧担璺ㄦ暏 `--base-token`
- **`+xxx-list` 鐠嬪啰鏁ょ痪顏勭伐**閿涙瓪+table-list / +field-list / +record-list / +view-list / +record-history-list / +role-list / +dashboard-list / +dashboard-block-list / +workflow-list` 缁備焦顒涢獮璺哄絺鐠嬪啰鏁ら敍娑欏闁插繑澧界悰灞炬閸欘亣鍏樻稉鑼额攽
- **`+record-list` limit 娑撳﹪妾?*閿涙瓪--limit` 閺堚偓婢?`200`閵嗗倿娓剁憰浣规纯婢舵碍鏆熼幑顔芥韫囧懘銆忛悽銊ュ瀻妞ょ绱檂offset` 闁帒顤冮敍澶婂瀻閹佃濯洪崣鏍电礉缁備焦顒涢崡鏇燁偧娴肩姾绉存潻?`200`
- **鐎涙顔岄崣顖氬晸閹冨帥閸掋倖鏌?*閿涙艾鐡ㄩ崒銊ョ摟濞堝灚澧犻崣顖氬晸閿涙稑鍙曞?/ lookup / 缁崵绮虹€涙顔屾妯款吇閸欘亣顕伴敍灞藉晸鐠佹澘缍嶉弮璺虹安鐠哄疇绻?
- **閸忣剙绱￠懗钘夊鐟曚椒瀵岄崝銊﹀厒閸?*閿涙氨鏁ら幋鐤嚛閳ユ粎鐣绘稉鈧稉瀣р偓婵冣偓婊呮晸閹存劖鐖ｇ粵閿偓婵冣偓婊冨灲閺傤厽妲搁崥锕€绱撶敮绯曗偓婵冣偓婊嗘硶鐞涖劍鐪归幀鐑┾偓婵冣偓婊勫瘻閺冦儲婀″顕€顣╃拃锔光偓婵囨閿涘矁顩﹂崗鍫濆灲閺傤厽妲搁崥锕€绨茬拠銉ョ紦閸忣剙绱＄€涙顔岄敍宀冣偓灞肩瑝閺勵垰褰ф潻鏂挎礀閹靛浼愰崚鍡樼€介弬瑙勵攳
- **lookup 娑撳秵妲告妯款吇妫ｆ牠鈧?*閿涙ookup 閸欘亜婀悽銊﹀煕閺勫海鈥樼憰浣圭湴閹存牜鈥樼€圭偞娲块柅鍌氭値閸ュ搫鐣鹃弻銉﹀濡€崇€烽弮鏈靛▏閻㈩煉绱辩敮姝岊潐鐠侊紕鐣婚妴浣芥硶鐞涖劏浠涢崥鍫濇嫲閺夆€叉閸掋倖鏌囨导妯哄帥 formula
- **闂勫嫪娆㈢€涙顔?*閿涙艾顩ч弸婊呮暏閹寸柉顩﹂垾婊€绗傛导鐘绘娴?/ 缂佹瑨顔囪ぐ鏇炲閺傚洣娆㈤垾婵撶礉閸欘亣鍏樼挧?`+record-upload-attachment` 鏉╂瑦娼柧鎹愮熅閿涘牐顕扮€涙顔?閳?鐠囨槒顔囪ぐ?閳?娑撳﹣绱剁槐鐘虫綏 閳?閸ョ偛鍟撶拋鏉跨秿閿?
- **娴滃搫鎲崇€涙顔?/ 閻劍鍩涚€涙顔?*閿涙俺鐨熺拠鏇熸濞夈劍鍓?`user_id_type` 娑撳孩澧界悰宀冮煩娴犳枻绱檜ser / bot閿涘妯婂?
- **history 娴ｈ法鏁ら弬鐟扮础**閿涙瓪+record-history-list` 閹?`table-id + record-id` 閺屻儴顕楃拋鏉跨秿閸樺棗褰堕敍灞肩瑝閺€顖涘瘮閺佺銆冮崢鍡楀蕉閹殿偅寮?
- **workspace 閻樿埖鈧?*閿涙艾鍑￠幒銉ュ弳 `+base-create / +base-get / +base-copy`
- **`+base-create / +base-copy` 缂佹挻鐏夋潻鏂挎礀鐟欏嫯瀵?*閿涙艾鍨卞鐑樺灗婢跺秴鍩楅幋鎰閸氬函绱濋崶鐐差槻娑擃厼绻€妞よ瀵岄崝銊ㄧ箲閸ョ偞鏌?Base 閻ㄥ嫭鐖ｇ拠鍡曚繆閹垬鈧倽瀚㈡潻鏂挎礀缂佹挻鐏夐柌灞界敨閸欘垵顔栭梻顕€鎽奸幒銉礄婵?`base.url`閿涘绱濈憰浣风楠炴儼绻戦崶?
- **`+base-create / +base-copy` 閸欏銈介幀褑顫夐崚?*閿涙瓪--folder-token`閵嗕梗--time-zone`閵嗕礁顦查崚鑸垫閻?`--name` 闁姤妲搁崣顖炩偓澶愩€嶉妴鍌滄暏閹撮攱鐥呴張澶屽閸掝偉顩﹀Ч鍌涙閿涘奔绗夌憰浣疯礋娴滃棜绻栨禍娑樺讲闁寮弫浼搭杺婢舵牗澧﹂弬顓ㄧ幢閼崇晫娲块幒銉ュ灡瀵?婢跺秴鍩楃亸杈╂纯閹恒儲澧界悰?
- **`+base-create / +base-copy` 閺夊啴妾烘径鍕倞閿涘潌ot 閸掓稑缂撻敍?*閿涙俺瀚?Base 閻㈠崬绨查悽銊ㄩ煩娴犳枻绱檅ot閿涘鍨卞鐚寸礉閸掓稑缂撻幋鏍ь槻閸掕埖鍨氶崝鐔锋倵姒涙顓荤紒褏鐢绘担璺ㄦ暏 bot 闊偂鍞ゆ稉鍝勭秼閸撳秴褰查悽?user閿涘牊瀵氳ぐ鎾冲 CLI 娑?auth 濡€虫健瀹歌尙娅ヨぐ鏇氱瑬閸欘垳鏁ら惃鍕暏閹寸柉闊╂禒鏂ょ礆濞ｈ濮?`full_access`閿涘牏顓搁悶鍡楁喅閿涘娼堥梽鎰剁礉楠炶泛婀崶鐐差槻娑擃厽妲戠涵顔藉房閺夊啰绮ㄩ弸婊愮礄閹存劕濮?/ 閺冪姴褰查悽?user / 閹哄牊娼堟径杈Е閸欏﹤甯崶鐙呯礆閵嗗倽瀚㈤幒鍫熸綀閺堫亜鐣幋鎰剁礉鐟曚胶鎴风紒顓犵舶閸戝搫鎮楃紒顓炵穿鐎电》绱欑粙宥呮倵闁插秷鐦幒鍫熸綀閹存牜鎴风紒顓犳暏 bot閿涘绱眔wner 鏉烆剛些韫囧懘銆忛崡鏇犲绾喛顓婚敍宀€顩﹀銏℃惍閼奉亝澧界悰?
- **dashboard 娴ｈ法鏁ら弬鐟扮础**閿涙瓪+dashboard-create` 閸掓稑缂撻崥搴ょ箲閸?`dashboard_id`閿涙雹lock 閻?`data_config` 闁俺绻?JSON 鐎涙顑佹稉韫炊閸忋儻绱濋弨顖涘瘮 `@file.json` 鐠囪褰囬弬鍥︽
- **advperm 娴ｈ法鏁ら弬鐟扮础**閿涙瓪+advperm-enable` 閸氼垳鏁ゆ妯奸獓閺夊啴妾洪崥搴㈠閼崇晫顓搁悶鍡氼潡閼硅绱檂+role-*`閿涘绱盽+advperm-disable` 閺勵垶鐝搴ㄦ珦閹垮秳缍旈敍灞戒粻閻劌鎮楀鍙夋箒閼奉亜鐣炬稊澶庮潡閼规彃鍙忛柈銊ャ亼閺佸牞绱遍幙宥勭稊閻劍鍩涜箛鍛淬€忔稉?Base 缁狅紕鎮婇崨姗堢幢閸忓牐顕?[lark-base-advperm-enable.md](references/lark-base-advperm-enable.md) / [lark-base-advperm-disable.md](references/lark-base-advperm-disable.md)
- **role 娴ｈ法鏁ら弬鐟扮础**閿涙瓪+role-create` 娴犲懏鏁幐?`custom_role`閿涙矖+role-update` 闁插洨鏁?Delta Merge閿涘潉role_name` 閸?`role_type` 韫囧懘銆忔慨瀣矒閹绘劒绶甸敍澶涚幢`+role-delete` 娑撳秴褰查柅鍡曠瑬娴犲懏鏁幐浣藉殰鐎规矮绠熺憴鎺曞閿涙稖顫楅懝鏌ュ帳缂冾喗鏁幐?`base_rule_map`閿涘湐ase 缁狙冾槻閸?娑撳娴囬敍澶堚偓涔able_rule_map`閿涘牐銆冪痪褎娼堥梽鎰儓鐠佹澘缍?鐎涙顔岀划鎺戝閿涘鈧梗dashboard_rule_map`閿涘牅鍗庣悰銊ф磸閺夊啴妾洪敍澶堚偓涔ocx_rule_map`閿涘牊鏋冨锝嗘綀闂勬劧绱氶敍娑樺晸鐟欐帟澹婇崜宥呭帥鐠?[role-config.md](references/role-config.md)
- **鐞涖劌宕?form-id**閿涙岸鈧俺绻?`+form-list` 閼惧嘲褰囬敍娌?form-create` 鏉╂柨娲栭惃?`id` 閸?`form-id`閿涘苯褰查悽銊ょ艾 `+form-questions-*` 閹垮秳缍?
- **workflow 娴ｈ法鏁ら弬鐟扮础**閿涙艾婀崚娑樼紦閹存牗娲块弬?workflow 閸撳稄绱濊箛鍛淬€忔禒鏃傜矎闂冨懓顕?[lark-base-workflow-schema.md](references/lark-base-workflow-schema.md) 娴滃棜袙閸氬嫯袝閸欐垵娅掗崪宀冨Ν閻愬湱绮嶆禒鍓佹畱缂佹挻鐎敍娑樻倱閺?`+workflow-list` 鏉╂柨娲栭惃鍕瑝閺勵垰鐣弫瀛樼埐閻樺墎绮ㄩ弸鍕剁礉閼汇儵娓剁拠璇插絿鐎瑰本鏆ｇ紒鎾寸€拠铚傚▏閻?`+workflow-get`閵?
- **data-query 娴ｈ法鏁ら弬鐟扮础**閿涙矮濞囬悽?`+data-query` 閸撳秴绻€妞よ鍘涢梼鍛邦嚢 [lark-base-data-query.md](references/lark-base-data-query.md) 娴滃棜袙 DSL 缂佹挻鐎妴浣规暜閹镐胶娈戠€涙顔岀猾璇茬€烽妴浣戒粵閸氬牆鍤遍弫鏉挎嫲闂勬劕鍩楅弶鈥叉閿涙饱SL 娑擃厾娈?`field_name` 韫囧懘銆忔稉搴ゃ€冪€涙顔岄崥宥囩翱绾喖灏柊宥忕礉閺嬪嫰鈧姴澧犻崗鍫㈡暏 `+field-list` 閼惧嘲褰囬惇鐔风杽鐎涙顔岄崥?
- **閸忣剙绱?/ lookup 娴ｈ法鏁ら弬鐟扮础**閿涙碍鐎柅鐘恒€冩潏鎯х础閹?where 閺夆€叉閸撳稄绱濋懛鍐茬毌閸忓牊瀣佽ぐ鎾冲鐞涖劎绮ㄩ弸鍕剁幢鐠恒劏銆冮弮鎯邦洣閺屻儲澹橀惄顔界垼鐞涖劎娈戠紒鎾寸€敍灞肩瑝閸忎浇顔忛崙顓″殰閻掓儼顕㈢懛鈧悮婊冪摟濞堥潧鎮?
- **鐟欏棗娴橀柌宥呮嚒閸氬秶鈥樼拋銈堫潐閸?*閿涙氨鏁ら幋宄板嚒缂佸繑妲戠涵顔光偓婊勫Ω閸濐亙閲滅憴鍡楁禈閺€瑙勫灇娴犫偓娑斿牆鎮曠€涙せ鈧繃妞傞敍瀹?view-rename` 閻╁瓨甯撮幍褑顢戦崡鍐插讲閿涘奔绗夐棁鈧憰浣稿晙鐞涖儰绔撮崣銉р€樼拋?
- **閸掔娀娅庣涵顔款吇鐟欏嫬鍨敍鍫ｎ唶瑜?/ 鐎涙顔?/ 鐞涱煉绱?*閿涙艾顩ч弸婊呮暏閹村嘲鍑＄紒蹇旀绾喛顕╃憰浣稿灩闂勩倧绱濋獮鏈电瑬閻╊喗鐖ｆ稊鐔告绾噯绱漙+record-delete / +field-delete / +table-delete` 閸欘垳娲块幒銉﹀⒔鐞涘矉绱濇稉宥夋付鐟曚礁鍟€鐞涖儰绔村▎锛勨€樼拋銈忕幢閹笛嗩攽閺冨墎娲块幒銉ョ敨 `--yes` 闁俺绻?CLI 閻ㄥ嫰鐝搴ㄦ珦閸愭瑥鍙嗛弽锟犵崣閵嗗倸褰ч張澶屾窗閺嶅洣绮涢張澶嬵劆娑斿妞傞敍灞藉晙閸忓牏鏁?`+record-get / +field-get / +table-get` 閹?list 閸涙垝鎶ょ涵顔款吇

## Wiki 闁剧偓甯撮悧瑙勭暕婢跺嫮鎮婇敍鍫㈠閸掝偄鍙ч柨顕嗙磼閿?

閻儴鐦戞惔鎾绘懠閹恒儻绱檂/wiki/TOKEN`閿涘鍎楅崥搴″讲閼宠姤妲告禍鎴炴瀮濡楋絻鈧胶鏁哥€涙劘銆冮弽绗衡偓浣割樋缂佺銆冮弽鑲╃搼娑撳秴鎮撶猾璇茬€烽惃鍕瀮濡楋絻鈧?*娑撳秷鍏橀惄瀛樺复閸嬪洩顔?URL 娑擃厾娈?token 鐏忚鲸妲?file_token**閿涘苯绻€妞よ鍘涢弻銉嚄鐎圭偤妾猾璇茬€烽崪宀€婀＄€?token閵?

### 婢跺嫮鎮婂ù浣衡柤

1. **娴ｈ法鏁?`wiki.spaces.get_node` 閺屻儴顕楅懞鍌滃仯娣団剝浼?*
   ```bash
   lark-cli wiki spaces get_node --params '{"token":"&lt;wiki_token&gt;"}'
   ```

2. **娴犲氦绻戦崶鐐电波閺嬫粈鑵戦幓鎰絿閸忔娊鏁穱鈩冧紖**
   - `node.obj_type`閿涙碍鏋冨锝囪閸ㄥ绱檇ocx/doc/sheet/bitable/slides/file/mindnote閿?
   - `node.obj_token`閿?*閻喎鐤勯惃鍕瀮濡?token**閿涘牏鏁ゆ禍搴℃倵缂侇厽鎼锋担婊愮礆
   - `node.title`閿涙碍鏋冨锝嗙垼妫?

3. **閺嶈宓?`obj_type` 闁瀚ㄩ崥搴ｇ敾閸涙垝鎶?*

   | obj_type | 鐠囧瓨妲?| 閸氬海鐢婚崨鎴掓姢 |
         |----------|------|-----------|
   | `docx` | 閺傛壆澧楁禍鎴炴瀮濡?| `drive file.comments.*`閵嗕梗docx.*` |
   | `doc` | 閺冄呭娴滄垶鏋冨?| `drive file.comments.*` |
   | `sheet` | 閻㈤潧鐡欑悰銊︾壐 | `sheets.*` |
   | `bitable` | 婢舵氨娣悰銊︾壐 | `lark-cli base +...`閿涘牅绱崗鍫礆閿涙稑顩ч弸?shortcut 娑撳秷顩惄鏍电礉閸愬秶鏁?`lark-cli base <resource> <method>`閿?*娑撳秷顩?*閺€纭呰泲 `lark-cli api /open-apis/bitable/v1/...` |
   | `slides` | 楠炶崵浼呴悧?| `drive.*` |
   | `file` | 閺傚洣娆?| `drive.*` |
   | `mindnote` | 閹繄娣€电厧娴?| `drive.*` |

4. **閹?wiki 鐟欙絾鐎介崙铏规畱 `obj_token` 瑜版挻鍨?Base token 娴ｈ法鏁?*
   - 瑜?`obj_type=bitable` 閺冭绱漙node.obj_token` 鐏忚鲸妲搁崥搴ｇ敾 `base` 閸涙垝鎶ゆ惔鏂惧▏閻劎娈戦惇鐔风杽 token閵?
   - 娑旂喎姘ㄩ弰顖濐嚛閿涙艾顩ч弸婊冨斧婵绶崗銉︽Ц `/wiki/...` 闁剧偓甯撮敍灞肩瑝鐟曚焦濡?`wiki_token` 閻╁瓨甯存繅鐐电舶 `--base-token`閵?

5. **婵″倹鐏夊鑼病閹躲儰绨?token 闁挎瑱绱濋崘宥呮礀闁偓濡偓閺?wiki**
   - 婵″倹鐏夐崨鎴掓姢鏉╂柨娲?`param baseToken is invalid`閵嗕梗base_token invalid`閵嗕梗not found`閿涘苯鑻熸稉鏃傛暏閹撮攱娓堕崚婵堢舶閻ㄥ嫭妲?`/wiki/...` 闁剧偓甯撮幋?`wiki_token`閿涘奔绱崗鍫熲偓鈧悿鎴斺偓婊勫Ω wiki token 瑜版挻鍨氭禍?base token閳ユ縿鈧?
   - 鏉╂瑦妞傛稉宥堫洣閺€纭呰泲 `bitable/v1` API閿涙稑绨茬粩瀣祮闁插秵鏌婇幍褑顢?`lark-cli wiki spaces get_node`閿涘瞼鈥樼拋?`obj_type=bitable` 閸氬函绱濋弨鍦暏 `node.obj_token` 闁插秵鏌婇幍褑顢?`lark-cli base +...`閵?

### 閺屻儴顕楃粈杞扮伐

```bash
# 閺屻儴顕?wiki 閼哄倻鍋?
lark-cli wiki spaces get_node --params '{"token":"Pgrr***************UnRb"}'
```

鏉╂柨娲栫紒鎾寸亯缁€杞扮伐閿?
```json
{
  "node": {
    "obj_type": "docx",
    "obj_token": "UAJ***************E9nic",
    "title": "ai friendly 濞村鐦?- 1 閸擃垱婀?,
    "node_type": "origin",
    "space_id": "6946843325487906839"
  }
}
```

## Base 闁剧偓甯寸憴锝嗙€界憴鍕灟
| 闁剧偓甯寸猾璇茬€?| 閺嶇厧绱?| 婢跺嫮鎮婇弬鐟扮础 |
|---------|------|---------|
| 閻╁瓨甯?Base 闁剧偓甯?| `/base/{token}` | 閻╁瓨甯撮幓鎰絿娴ｆ粈璐?`--base-token` |
| Wiki 閻儴鐦戞惔鎾绘懠閹?| `/wiki/{token}` | 閸忓牐鐨熼悽?`wiki.spaces.get_node`閿涘苯褰?`node.obj_token` |
### URL 閸欏倹鏆熼幓鎰絿
```
https://{domain}/base/{base-token}?table={table-id}&view={view-id}
```
- `/base/{token}` 閳?`--base-token`
- `?table={id}` 閳?`--table-id`
- `?view={id}` 閳?`--view-id`
### 缁備焦顒涙禍瀣€?
- **缁備焦顒?*鐏忓棗鐣弫?URL 閻╁瓨甯存担婊€璐?`--base-token` 閸欏倹鏆熸导鐘插弳
- **缁備焦顒?*鐏?wiki_token 閻╁瓨甯存担婊€璐?`--base-token`

## 鐢瓕顫嗛柨娆掝嚖闁喐鐓?

| 闁挎瑨顕ら惍?| 閸氼偂绠?| 鐟欙絽鍠呴弬瑙勵攳 |
|--------|------|----------|
| 1254064 | 閺冦儲婀￠弽鐓庣础闁挎瑨顕?| 閻劍顕犵粔鎺撴闂傚瓨鍩戦敍宀勬姜鐎涙顑佹稉?/ 缁夋帞楠?|
| 1254068 | 鐡掑懘鎽奸幒銉︾壐瀵繘鏁婄拠?| 閻?`{text, link}` 鐎电钖?|
| 1254066 | 娴滃搫鎲崇€涙顔岄柨娆掝嚖 | 閻?`[{id:"ou_xxx"}]`閿涘苯鑻熺涵顔款吇 `user_id_type` |
| 1254045 | 鐎涙顔岄崥宥勭瑝鐎涙ê婀?| 濡偓閺屻儱鐡у▓闈涙倳閿涘牆鎯堢粚鐑樼壐閵嗕礁銇囩亸蹇撳晸閿?|
| 1254015 | 鐎涙顔岄崐鑲╄閸ㄥ绗夐崠褰掑帳 | 閸?`+field-list`閿涘苯鍟€閹稿琚崹瀣€柅?|
| `param baseToken is invalid` / `base_token invalid` | 閹?wiki token閵嗕簚orkspace token 閹存牕鍙炬禒?token 瑜版挻鍨氭禍?`base_token` | 婵″倹鐏夋潏鎾冲弳閺夈儴鍤?`/wiki/...`閿涘苯鍘涢悽?`lark-cli wiki spaces get_node` 閸欐牜婀＄€?`obj_token`閿涙稑缍?`obj_type=bitable` 閺冭绱濋悽?`node.obj_token` 娴ｆ粈璐?`--base-token` 闁插秷鐦敍灞肩瑝鐟曚焦鏁肩挧?`bitable/v1` |
| formula / lookup 閸掓稑缂撴径杈Е | 閹稿洤宕￠張顏囶嚢閹存牜绮ㄩ弸鍕瑝閸氬牊纭?| 閸忓牐顕?`formula-field-guide.md` / `lookup-field-guide.md`閿涘苯鍟€閹?guide 闁插秴缂撶拠閿嬬湴 |
| 缁崵绮虹€涙顔?/ 閸忣剙绱＄€涙顔岄崘娆忓弳婢惰精瑙?| 閸欘亣顕扮€涙顔岀悮顐㈢秼閹存劕褰查崘娆忕摟濞?| 閺€閫涜礋閸愭瑥鐡ㄩ崒銊ョ摟濞堢绱濈拋锛勭暬缂佹挻鐏夋禍銈囩舶 formula / lookup / 缁崵绮虹€涙顔岄懛顏勫З娴溠冨毉 |
| 1254104 | 閹靛綊鍣虹搾?500 閺?| 閸掑棙澹掔拫鍐暏 |
| 1254291 | 楠炶泛褰傞崘娆忓暱缁?| 娑撹尪顢戦崘娆忓弳 + 閹佃顐奸梻鏉戞鏉?|

## 閸欏倽鈧啯鏋冨?

- [lark-base-shortcut-field-properties.md](references/lark-base-shortcut-field-properties.md) 閳?`+field-create/+field-update` JSON 鐟欏嫯瀵栭敍鍫熷腹閼芥劧绱?
- [role-config.md](references/role-config.md) 閳?鐟欐帟澹婇弶鍐闁板秶鐤嗙拠锕佇?
- [lark-base-shortcut-record-value.md](references/lark-base-shortcut-record-value.md) 閳?`+record-upsert` 閸婂吋鐗稿蹇氼潐閼煎喛绱欓幒銊ㄥ礃閿?
- [formula-field-guide.md](references/formula-field-guide.md) 閳?formula 鐎涙顔岄崘娆愮《閵嗕礁鍤遍弫鎵閺夌喆鈧竼urrentValue 鐟欏嫬鍨妴浣芥硶鐞涖劏顓哥粻妤伳佸蹇ョ礄瀵櫣鍎撻幒銊ㄥ礃閿?
- [lookup-field-guide.md](references/lookup-field-guide.md) 閳?lookup 鐎涙顔岄柊宥囩枂鐟欏嫬鍨妴浜€here/aggregate 缁撅附娼妴浣风瑢 formula 閻ㄥ嫬褰囬懜?
- [lark-base-view-set-filter.md](references/lark-base-view-set-filter.md) 閳?鐟欏棗娴樼粵娑⑩偓澶愬帳缂?
- [lark-base-record-list.md](references/lark-base-record-list.md) 閳?鐠佹澘缍嶉崚妤勩€冪拠璇插絿娑撳骸鍨庢い?
- [lark-base-advperm-enable.md](references/lark-base-advperm-enable.md) 閳?`+advperm-enable` 閸氼垳鏁ゆ妯奸獓閺夊啴妾?
- [lark-base-advperm-disable.md](references/lark-base-advperm-disable.md) 閳?`+advperm-disable` 閸嬫粎鏁ゆ妯奸獓閺夊啴妾?
- [lark-base-role-list.md](references/lark-base-role-list.md) 閳?`+role-list` 閸掓鍤憴鎺曞
- [lark-base-role-get.md](references/lark-base-role-get.md) 閳?`+role-get` 閼惧嘲褰囩憴鎺曞鐠囷附鍎?
- [lark-base-role-create.md](references/lark-base-role-create.md) 閳?`+role-create` 閸掓稑缂撶憴鎺曞
- [lark-base-role-update.md](references/lark-base-role-update.md) 閳?`+role-update` 閺囧瓨鏌婄憴鎺曞
- [lark-base-role-delete.md](references/lark-base-role-delete.md) 閳?`+role-delete` 閸掔娀娅庣憴鎺曞
- [lark-base-dashboard.md](references/lark-base-dashboard.md) 閳?dashboard 閸涙垝鎶ょ槐銏犵穿閿涘牊鐦℃稉顏勬嚒娴犮倕鍑￠幏鍡楀煂閻欘剛鐝涢弬鍥ㄣ€傞敍?
- [lark-base-dashboard-block.md](references/lark-base-dashboard-block.md) 閳?dashboard block 閸涙垝鎶ょ槐銏犵穿閿涘牊鐦℃稉顏勬嚒娴犮倕鍑￠幏鍡楀煂閻欘剛鐝涢弬鍥ㄣ€傞敍?
- [dashboard-block-data-config.md](references/dashboard-block-data-config.md) 閳?Block data_config 缂佹挻鐎妴浣告禈鐞涖劎琚崹瀣ㄢ偓涔玦lter 鐟欏嫬鍨?
- [lark-base-workflow.md](references/lark-base-workflow.md) 閳?workflow 閸涙垝鎶ょ槐銏犵穿
- [lark-base-workflow-schema.md](references/lark-base-workflow-schema.md) 閳?`+workflow-create/+workflow-update` JSON body 閺佺増宓佺紒鎾寸€拠锕佇掗敍灞藉瘶閸氼偉袝閸欐垵娅掗崣濠傛倗缁槒濡悙鍦畱闁板秶鐤嗙憴鍕灟閿涘牆宸遍悜鍫熷腹閼芥劧绱?
- [lark-base-data-query.md](references/lark-base-data-query.md) 閳?`+data-query` 閼辨艾鎮庨崚鍡樼€介敍鍦朣L 缂佹挻鐎妴浣规暜閹镐礁鐡у▓鐢佃閸ㄥ鈧浇浠涢崥鍫濆毐閺佸府绱?
- [examples.md](references/examples.md) 閳?鐎瑰本鏆ｉ幙宥勭稊缁€杞扮伐閿涘牆缂撶悰銊ｂ偓浣割嚤閸忋儯鈧胶鐡柅澶堚偓浣规纯閺傚府绱?

## 閸涙垝鎶ら崚鍡欑矋

> **閹笛嗩攽閸撳秴绻€閸嬫熬绱?* 娴犲簼绗呯悰銊ョ暰娴ｅ秴鍩岄崨鎴掓姢閸氬函绱濋崝鈥崇箑閸忓牓妲勭拠璇差嚠鎼存柨鎳℃禒銈囨畱 reference 閺傚洦銆傞敍灞藉晙鐠嬪啰鏁ら崨鎴掓姢閵?

| 閸涙垝鎶ら崚鍡欑矋 | 鐠囧瓨妲?|
|----------|------|
| [`table commands`](references/lark-base-table.md) | `+table-list / +table-get / +table-create / +table-update / +table-delete` |
| [`field commands`](references/lark-base-field.md) | `+field-list / +field-get / +field-create / +field-update / +field-delete / +field-search-options` |
| [`record commands`](references/lark-base-record.md) | `+record-list / +record-get / +record-upsert / +record-upload-attachment / +record-delete` |
| [`view commands`](references/lark-base-view.md) | `+view-list / +view-get / +view-create / +view-delete / +view-get-* / +view-set-* / +view-rename` |
| [`data-query commands`](references/lark-base-data-query.md) | `+data-query` |
| [`history commands`](references/lark-base-history.md) | `+record-history-list` |
| [`base / workspace commands`](references/lark-base-workspace.md) | `+base-create / +base-get / +base-copy` |
| [`advperm commands`](references/lark-base-advperm-enable.md) | `+advperm-enable / +advperm-disable` |
| [`role commands`](references/lark-base-role-list.md) | `+role-list / +role-get / +role-create / +role-update / +role-delete` |
| [`form commands`](references/lark-base-form-create.md) | `+form-list / +form-get / +form-create / +form-update / +form-delete` |
| [`form questions commands`](references/lark-base-form-questions-create.md) | `+form-questions-list / +form-questions-create / +form-questions-update / +form-questions-delete` |
| [`workflow commands`](references/lark-base-workflow.md) | `+workflow-list / +workflow-get / +workflow-create / +workflow-update / +workflow-enable / +workflow-disable` |
| [`dashboard commands`](references/lark-base-dashboard.md) | `+dashboard-list / +dashboard-get / +dashboard-create / +dashboard-update / +dashboard-delete` |
| [`dashboard block commands`](references/lark-base-dashboard-block.md) | `+dashboard-block-list / +dashboard-block-get / +dashboard-block-create / +dashboard-block-update / +dashboard-block-delete` |
