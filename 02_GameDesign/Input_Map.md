# Input Map

## Actions (Godot InputMap)

| Action | Gamepad | Keyboard/Mouse | Notes |
|--------|---------|----------------|-------|
| move_left | Left Stick Left | A / Left Arrow | |
| move_right | Left Stick Right | D / Right Arrow | |
| move_up | Left Stick Up | W / Up Arrow | For ladders/ledges |
| move_down | Left Stick Down | S / Down Arrow | For crouch/ledges |
| jump | A | Space | |
| dash | B | Shift | 4 directions |
| crouch | Left Stick Click | Ctrl | Hold |
| roll | Right Bumper | R | Ground only |
| interact | X | E | Terminals, NPCs, items |
| aim | Left Trigger | Right Mouse Hold | Sniper / Grapple preview |
| fire | Right Trigger | Left Mouse | Sniper shot / Grapple launch |
| gadget_1 | D-Pad Up | 1 | EMP |
| gadget_2 | D-Pad Right | 2 | Smoke |
| gadget_3 | D-Pad Down | 3 | Decoy |
| time_dagger | D-Pad Left | Q | Toggle |
| reload | Y | F | Sniper only |
| map | Select / Back | Tab | Minimap toggle |
| inventory | Start | I | Inventory screen |
| pause | Start (hold) | Esc | Pause menu |

## Dual Input Logic
`InputManager` detects last active device:
- Mouse movement > 0 → mouse mode (show cursor for aim).
- Any gamepad button/stick → pad mode (hide cursor, snap UI focus).
- UI navigation: gamepad D-Pad/Left Stick or KB arrows + Enter.

---

## Связанные разделы

- [[MOC_02_GameDesign]]
- [[Movement_and_Acrobatics_v2]]
- [[Combat_and_Weapons_v2]]
- [[GDD_Core_v2]]
