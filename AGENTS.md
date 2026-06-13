# Project Working Agreements

## Project Purpose

This repository packages the `knowledge-base-illustrator` Codex Skill and its original soft crumpled paper mascot references as a standalone project.

## Source Of Truth

- Installable Skill: `knowledge-base-illustrator/`
- User-facing introduction: `README.md`
- Project hero image: `assets/knowledge-base-illustrator-hero.png`
- Character references: `knowledge-base-illustrator/assets/reference/`

## Editing Rules

- Keep the installable Skill self-contained; do not add private absolute paths.
- Preserve the mascot invariants documented in `references/visual-language.md`.
- Do not replace reference boards without explicit approval.
- Keep generated images out of temporary tool folders by copying accepted outputs into this repository.
- Do not add a license or change asset-use permissions without explicit owner approval.

## Validation

- Run Codex `quick_validate.py` against `knowledge-base-illustrator/` after Skill changes.
- Run the local health audit after substantial workflow or structure changes.
- For strict bitmap edits, run `scripts/verify_image.ps1` and inspect the result visually.
