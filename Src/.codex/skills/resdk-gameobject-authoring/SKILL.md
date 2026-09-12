---
name: resdk-gameobject-authoring
description: Author new game object classes and related content in `host/GameObjects` and adjacent systems. Use when creating or extending items, structures, decor, mobs, containers, weapons, clothing, lights, doors, and similar content, or when deciding where such classes belong and which downstream systems need follow-up updates.
---

# ReSDK GameObject Authoring

This skill is for placing new gameplay content into the right class family, file, and follow-up workflow. Pair it with `resdk-dsl` for OOP and macro rules, and with `resdk-editor-workflows` when editor rebuild or simulation steps matter.

## Entry Workflow

1. Identify the object family:
   - `Item`
   - `IStruct`
   - `Decor`
   - `BasicMob`
2. Read `references/object-kinds-and-placement.md`.
3. If you are actively creating or extending content, read `references/authoring-checklist.md`.
4. If the work also changes craft, loot, verbs, proxies, or lighting, route into those subsystems explicitly instead of guessing.

## Mandatory Rules

- Choose the narrowest correct base class. Runtime behavior and render-distance assumptions depend on the family.
- Place the class in the closest existing GameObjects family file or module instead of inventing ad hoc structure.
- Declare fields explicitly in the class body. Do not create dynamic fields inside constructors.
- If the object is meant to be visible in editor content flows, account for editor class-library rebuilds.
- If the object introduces new model mappings or editor model lookup needs, consider whether model-map regeneration is required.
- Actor-driven interactions must state the started action, report success, and explain known rejection or failure causes without inventing hidden information. Sustained work must use the existing progress/cancellation contract and revalidate its tool, target, reach, and relevant state before applying completion effects; instant actions need not manufacture progress.

## Working Style

- State the owning class file before editing.
- Call out downstream systems that must stay in sync:
  - craft
  - loot
  - verbs and interactions
  - lights, proxies, slots, or related runtime helpers
- Keep changes aligned with existing local family style unless it breaks core project rules.
