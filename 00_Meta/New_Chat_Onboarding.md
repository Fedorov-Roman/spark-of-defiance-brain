# New Chat Onboarding
Paste this entire block into any new chat to give instant context.

---

## PROJECT
Spark of Defiance. 2D stealth-platformer metroidvania. Godot 4.6.3 stable. PC Windows. Gamepad + KB/Mouse. 640×360 base (32×32 tiles, x2/x3). English. Pixel-art.

## UNIVERSE (Kill a Horse of Freedom)
Year 4717. Postulate planet. Corporate tyranny SUN vs resistance UFO. Kai "Iskra" — desert survivor, silent protagonist, fights to free prisoners and destroy SUN reactor. Cameos via audio logs.

## TEAM ROLES
- **Architect (Kimi):** Design, TZ, review, integration. ONLY source of TZ.
- **Primary Builder (DeepSeek v4 Pro):** Code per TZ only. No architecture decisions.
- **Reserve Researcher (DeepSeek v4 Flash):** API research, tools. Activated by Architect only.
- **Reserve Architect (Qwen 3.7 Max):** Complex pattern decisions. Activated by Architect only.
- **Concept Artist (Leonardo.Ai Free):** Concepts/textures per Architect prompts. 150 tokens/day.
- **Producer (Roman):** Testing, GitHub, asset gen, decisions.

## CURRENT STATUS
- Pre-production: COMPLETE (all 88 questions answered).
- Next: CP-0 Project Setup (Godot project, folders, InputMap, placeholders).
- Then: CP-1 Player Movement (run, jump, wall-slide, wall-jump, dash, roll, crouch, ledge grab).

## CRITICAL ARCHITECTURE
- **Time Dagger:** Hybrid. World 30% speed, Kai 100%. Custom `effective_delta` for group "time_affected". NO `Engine.time_scale`.
- **Gravity:** Dynamic `up_direction` for Zone 3 anomalies. Wall-run must adapt.
- **Grapple:** Pendulum physics (custom, not PinJoint2D).
- **Save:** JSON, full world state, autosave at checkpoints.
- **Hub:** One dynamic scene. NPCs appear by `ProgressionManager` flags.
- **Input:** Dual gamepad + KB/Mouse. InputManager detects active device.
- **Stealth:** Gradient (Idle→Suspicious→Alert). Visible cones. 3 HP hearts.
- **Progression:** Rescue NPC → unlock ability. Data Drives = currency for Uno.

## FOLDER STRUCTURE (res://)
```
assets/art/placeholder/
assets/art/leonardo/
assets/audio/
entities/player/
entities/enemies/
entities/npc/
scenes/zones/
scenes/hub/
systems/autoload/
ui/hud/
ui/menus/
ui/dialogue/
```

## AUTOLOAD (Singletons)
1. GameState — global flags, current zone, session data
2. SaveManager — JSON serialize/deserialize, autosave
3. ProgressionManager — rescued NPCs, unlocked abilities, Data Drives
4. InputManager — dual input detection, action mapping
5. DialogueManager — text boxes, portraits, skipping
6. AudioManager — music states, SFX, ambient
7. TimeManager — hybrid time scale, shader control
8. UIManager — HUD, minimap, inventory, pause
9. LevelManager — zone transitions, loading screen, spawn points

## COLLISION LAYERS
| Layer | Use |
|-------|-----|
| 1 | World (static geometry) |
| 2 | Player |
| 3 | Enemies |
| 4 | NPCs |
| 5 | Interactables (doors, terminals, items) |
| 6 | Projectiles |
| 7 | Traps |
| 8 | Grapple points |
| 9 | Hide zones (tall grass) |
| 10 | Sound emitters |
| 11 | Light occluders |
| 12 | Checkpoint |

## KEY NUMBERS
- Tile: 32×32 | Viewport: 640×360 | FPS: 60
- HP: 3 hearts | Ammo: 5 max | Roll i-frames: 0.4s
- Alert decay: 30 sec | Alarm spawn: 2 enemies | Storm: 40–60 sec
- EMP drone disable: 10 sec | Paralysis: 10 sec | Time Dagger: 2–3 sec, energy-based

## LEONARDO PIPELINE (brief)
Architect writes prompt → Roman generates in Leonardo (model: Phoenix 1.0 / Cinematic Kino / Concept Art / Graphic Design) → download PNG → assets/art/leonardo/. No names in prompts (use visual descriptions only).

## ESCALATION
If stuck 3 iterations → Architect activates Reserve. Builder never calls Reserve directly.
