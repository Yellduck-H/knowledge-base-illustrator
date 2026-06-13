---
name: knowledge-base-illustrator
description: Create, edit, and validate raster illustrations for knowledge-base notes, especially illustrations using the original soft crumpled paper mascot. Use when the user asks to visualize a note or concept, generate a knowledge-base illustration, apply the mascot style, repair a localized illustration defect, or check an illustration against the bundled visual rules.
---

# Knowledge Base Illustrator

## Purpose

Turn knowledge into a restrained, warm illustration while keeping the note readable and the soft crumpled paper mascot structurally consistent. Use the system `imagegen` Skill for bitmap generation and editing; this Skill supplies the content, visual, saving, and validation rules.

## Scope

Use one of three modes:

- **Generate**: create a new illustration from a note, paragraph, concept, or workflow.
- **Localized edit**: repair a named area while preserving all other pixels and content.
- **Validate**: inspect an existing illustration without changing it.

Do not use this Skill for Mermaid, Excalidraw, Canvas, ordinary photos, unrelated marketing images, or edits better performed in an existing SVG/code-native source.

## Required Context

1. Read the nearest `AGENTS.md`.
2. Read the exact target note or text supplied by the user.
3. Read [references/visual-language.md](references/visual-language.md).
4. Inspect only the bundled reference boards needed for the task:
   - `assets/reference/01-核心识别规范.png`
   - `assets/reference/02-性格动作规范.png`
   - `assets/reference/03-知识库应用与生成约束.png`
   - `assets/reference/04-角色三视图.png`
5. If the owning project provides a newer approved character specification, read it without weakening the bundled invariants.
6. For prompt construction, read [references/prompt-recipes.md](references/prompt-recipes.md).
7. Before accepting an output, read [references/qa-checklist.md](references/qa-checklist.md).

## Generate Workflow

1. Extract:
   - one core knowledge statement;
   - one physical metaphor;
   - one reader action or emotional function.
2. Choose a single scene. Do not combine several metaphors merely to fill space.
3. Write a compact scene specification:
   - intended note and asset role;
   - subject and metaphor;
   - mascot action;
   - composition and negative space;
   - exact text, if any;
   - invariants and avoid list.
4. Use the system `imagegen` Skill and its built-in `image_gen` path by default.
5. Inspect the result at full view and enlarged mascot view.
6. Iterate with one targeted correction at a time.
7. Save the accepted PNG inside the owning project. For Obsidian Vaults, prefer a descriptive filename under `wiki/assets/插画/`; do not overwrite an existing file unless the user requested replacement.
8. Add or update the note embed only when the request includes integration into the note.
9. Follow the owning project's logging rules after persistent changes. If no operation log is defined, report the changed files in the final response.

## Localized Edit Workflow

1. Inspect the exact edit target with `view_image`.
2. Record the target rectangle and list all invariants outside it.
3. Save a non-destructive backup before replacing a formal asset.
4. Use the system `imagegen` Skill with the `precise-object-edit` pattern.
5. Reject an output that changes layout, line weight, facial features, neighboring objects, or any region outside the requested target.
6. When a simple line/object repair can be made deterministically, prefer local compositing over accepting model-wide drift.
7. Run `scripts/verify_image.ps1` against the backup and target rectangle.
8. Replace the formal asset only after visual inspection and zero unexpected changes outside the target.

## Validate Workflow

1. Inspect the whole image.
2. Inspect every complete mascot at enlarged scale.
3. Apply the visual and technical checklist.
4. Separate:
   - verified defects;
   - possible defects requiring a closer crop;
   - acceptable stylization.
5. Do not modify the image unless the user asked for repair.

## Output Rules

- Keep knowledge content visually primary.
- Preserve large white space and avoid decorative clutter.
- Do not invent unsupported factual labels or text.
- Report the final saved path, generation/edit mode, prompt summary, and checks performed.
- State clearly when a visual property could only be checked manually.
- Never modify source-material directories, `.obsidian/`, or `AGENTS.md` unless the user explicitly requests a schema or governance change.

## Validation

- Run the system `quick_validate.py` after changing this Skill.
- Run `scripts/verify_image.ps1` after strict localized edits.
- Re-read every changed page and required log entry.
- After a real generation run, record recurring failure modes in the project documentation before changing the Skill.
