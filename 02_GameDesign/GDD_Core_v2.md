# GDD Core v2

## Identity
- **Genre:** 2D Stealth-Platformer / Metroidvania
- **Camera:** Side-scrolling, Camera2D with smoothing, integer zoom
- **Theme:** Sci-fi post-apocalyptic resistance
- **Mood:** Oppressive but hopeful; dark with neon accents
- **Inspirations:** Mark of the Ninja (stealth), Celeste (movement), Hollow Knight (exploration)

## Technical Base
- **Base Resolution:** 640×360 (20×11 tiles of 32×32)
- **Pixel Scale:** x2 (1280×720) or x3 (1920×1080)
- **Tile Size:** 32×32
- **Viewport:** `canvas_items` stretch, `NEAREST` filter
- **Camera:** Smooth follow, no rotation, snap to pixel grid
- **FPS:** 60 (physics tick 60 Hz)

## Player Character
- **Name:** Kai "Iskra"
- **Type:** Silent protagonist
- **Visual:** Hooded figure, red scarf, glowing cyan dagger, compact rifle
- **Size:** ~32×48 px (2 tiles tall)

## Core Loop
1. Infiltrate zone (stealth or neutralization)
2. Rescue NPC / collect Data Drive / reach objective
3. Return to Hub via Vspyshka (fast travel)
4. Unlock new ability / upgrade
5. Use new ability to reach previously inaccessible areas (backtracking)

## Progression Pillars
- **Stealth:** Avoid detection; use shadows, grass, decoys, smoke
- **Mobility:** Wall-slide, wall-jump, dash, grapple, ledge grab
- **Time:** Time Dagger for puzzles and combat advantage
- **Combat:** Non-lethal preferred; sniper for disable; knife for stealth takedown

## Win Condition
Destroy SUN reactor on Postulate after freeing all prisoners and collecting enough Data Drives.

## Loss Condition
HP reaches 0 (respawn at checkpoint). No permadeath.
