# 提示词配方

## 新插画

```text
Use case: scientific-educational
Asset type: Obsidian knowledge-base illustration
Primary request: Visualize the following knowledge with one clear physical metaphor: <核心知识>
Scene/backdrop: pure white background with generous negative space
Subject: the original soft crumpled paper mascot interacting with <知识对象>
Style/medium: warm pencil line drawing, ivory paper body, light warm-gray crease shading
Composition/framing: <横版/竖版/方形>; mascot occupies 12%-30%; reserve space for note content
Lighting/mood: quiet, warm, reassuring
Color palette: graphite black, ivory white, warm gray, one orange folded corner, minimal pale blue path lines
Text (verbatim): "<仅在必要时填写>"
Constraints: exactly two thin-line arms and two legs; small oval eyes; tiny centered mouth; about seven major folds; thick three-dimensional side profile; face area contains only eyes and mouth
Avoid: extra or missing limbs, limbs crossing the face, flat side profile, perfect sphere, dense wrinkles, thick cartoon outline, clutter, watermark, copied third-party IP features
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

一幅图只选一个主隐喻；辅助物体不超过三类。

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
