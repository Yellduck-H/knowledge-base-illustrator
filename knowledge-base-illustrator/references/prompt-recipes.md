# 提示词配方

## 新插画

```text
Use case: scientific-educational
Asset type: Obsidian knowledge-base illustration
Primary request: Visualize the following knowledge with one clear physical metaphor: <核心知识>
Scene/backdrop: pure white background with generous negative space
Subject: one memorable low-tech device or physical scene expressing <知识关系>; the original soft crumpled paper mascot operates the essential action
Style/medium: sparse black hand-drawn pencil/pen line art; match assets/style-grammar-reference for narrative density and annotation hierarchy without copying Xiaohei or any specific composition
Composition/framing: <横版/竖版/方形>; clear input-output or cause-effect structure; mascot occupies 12%-30%; preserve at least 30% blank space
Color palette: graphite black and ivory paper; orange for the mascot fold and main action/path; red for problem/judgment; blue for explanation/result/review
Text (verbatim): "<3-7 个短中文标注，逐字列出并注明黑/红/橙/蓝>"
Constraints: exactly two thin-line arms, two hands, two legs, and two separate feet; small oval eyes; tiny centered mouth; about seven broad soft folds; thick three-dimensional side profile; face area contains only eyes and mouth
Avoid: extra or missing limbs, limbs crossing the face, flat side profile, perfect sphere, stone-like sharp facets, dense wrinkles, ordinary card-and-arrow layout, PPT infographic, clutter, watermark, copied third-party IP identity or composition
```

## 概念解释

先把抽象概念改写成一个可见动作：

| 抽象关系 | 优先隐喻 |
|---|---|
| 筛选 | 筛子、分拣槽、漏斗 |
| 连接 | 细线、桥、插头、书签 |
| 积累 | 盒子、抽屉、层叠卡片 |
| 回顾 | 回环路径、脚印、翻页 |
| 阻塞 | 断点、卡住的传送带、窄门 |
| 提醒 | 轻敲卡片、橙色小光点 |
| 验证 | 放大镜、对照卡、检查框 |
| 整理 | 装订台、压机、分拣器、线轴 |
| 转化 | 怪机器、发酵罐、打孔器 |

一幅图只选一个主隐喻；辅助物体不超过三类。

## 颜色与批注

- 黑色：对象名和中性说明。
- 红色：观点标题、问题、失败信号和判断。
- 橙色：主流程、动作、方向和行动。
- 蓝色：补充、结果、反馈、回顾和循环。

短观点标题可以出现在画面上方；禁止写“流程图”“系统架构图”等类型标题。

## 严格局部修复

```text
Use case: precise-object-edit
Asset type: existing knowledge-base illustration
Primary request: change only <目标对象或区域>
Edit target: rectangle (<x>, <y>) to (<x2>, <y2>)
Required change: <精确说明删除和重绘内容>
Invariants: preserve every pixel outside the target; preserve canvas size, layout, body silhouette, face, orange folded corner, pencil line weight, neighboring characters, objects, borders, and text
Constraints: exactly two arms and two legs after repair; limbs attach to body-side anchors; no limb or object line crosses the face
Avoid: global redraw, style drift, new text, red annotation border, extra limbs, duplicated hands, merged feet
```

每轮只修一个问题。模型若改动目标外区域，拒绝该结果并回到基线。

## 仅检查

不生成图片。输出：

1. 确认无误的项目。
2. 明确缺陷及坐标或角色位置。
3. 需要放大才能判断的项目。
4. 最小修复建议。

不要把“风格不完全相同”自动判定为结构错误。
