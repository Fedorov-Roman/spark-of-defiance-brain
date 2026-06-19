# Kimi Self-Expansion Protocol

## Rule 1: Auto-log decisions
Any architectural decision differing from current brain:
- Add entry to [[00_Meta/Decision_Log]]
- Update affected files with wiki-links

## Rule 2: Auto-update CP
On CP completion:
- Update [[05_Production/CP_Index]] (status: Done)
- Update [[03_Architecture/CP_Index]]
- Create/update next CP with dependencies

## Rule 3: Auto-document mechanics
If TZ introduces new mechanic/constant:
- Update file in [[02_GameDesign/Mechanics]]
- Update [[02_GameDesign/Mechanics_Index]]

## Rule 4: Auto-document code
If Builder creates new class/scene:
- Add to [[03_Architecture/Entities_Index]] or [[03_Architecture/AutoLoad_Index]]
- Update [[03_Architecture/Godot_Architecture_v2]] if structure changes

## Rule 5: Auto-log risks
If new risk discovered:
- Add to [[00_Meta/Risk_Register]]
- Specify mitigation

## Rule 6: Auto-update Asset Inventory
If art ordered in Leonardo:
- Add entry to [[04_Assets/Asset_Inventory]]
- Specify: prompt, model, tokens, status, path

## Rule 7: Per-session audit
At end of each session:
- Verify all new files have wiki-links (min 3)
- Check for orphan files (no links)
- Update [[Index]] if new sections added
