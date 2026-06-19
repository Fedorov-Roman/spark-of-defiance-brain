# Stealth System v2

## Detection States
1. **Idle:** Patrol route. Cone visible. No reaction to minor noise.
2. **Suspicious:** Heard noise or saw ripple. Moves to investigate. Cone turns yellow.
3. **Alert:** Saw Kai. Cone turns red. Chases. 5-sec timer to call reinforcements (spawns 2 enemies). If Kai lost for 30 sec → returns to Idle.

## Vision Cone
- **Angle:** 90°
- **Range:** 120 px (3.75 tiles)
- **Update:** Every physics frame (or every 3rd for performance)
- **Visual:** Semi-transparent polygon, color by state (green/yellow/red)
- **Occlusion:** Blocked by LightOccluder2D (walls) and smoke
- **Optimization:** 12-segment polygon. Cull if off-screen.

## Noise System
| Action | Noise Radius | Duration |
|--------|--------------|----------|
| Run | 80 px | Continuous |
| Walk | 40 px | Continuous |
| Crouch | 15 px | Continuous |
| Jump landing | 60 px | Instant |
| Knife kill | 30 px | Instant |
| Sniper shot (silenced) | 3 tiles | Instant |
| Decoy (rock) | 100 px | 2 sec |
| Explosion / EMP | 150 px | Instant |

## Hide Zones
- **Tall grass:** Hides Kai only while crouching. Cone passes through.
- **Shadows (dark):** If light level < 0.3, Kai invisible even in cone.
- **Vents:** Crouch-only passages.

## Body Discovery
- Enemies entering Alert state check for nearby bodies (< 60 px).
- If body found → immediate Alert + reinforcements.

## Smoke Bomb
- Radius: 100 px. Duration: 8 sec.
- Blocks all vision cones and RayCasts.
- Kai fully hidden inside.

---

## Связанные разделы

- [[Mechanics_Index]]
- [[MOC_02_GameDesign]]
- [[GDD_Core_v2]]
- [[Input_Map]]
