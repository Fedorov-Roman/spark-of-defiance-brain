# Combat & Weapons v2

## Energy Knife
- **Damage:** 1 heart (instant kill on normal enemies from behind)
- **Angle:** Back only (180° arc). Side if enemy fully stunned/paralyzed.
- **Noise:** 30 px radius
- **Speed:** Instant (no animation lock longer than 0.3s)
- **Frontal attack:** Kai takes 1 damage, knocked back 40 px, enemy alerts.

## Sniper Rifle "Shadow Whisper"
- **Aim:** Hold aim button (LT / RMB) → line of sight indicator (dashed). Release to fire.
- **Direction:** Stick or mouse cursor.
- **Projectile:** Instant RayCast2D (hitscan). Range: 20 tiles.
- **Effect:** Paralyze target for 10 sec. Disable electronics (drones fall).
- **Damage:** None (non-lethal).
- **Ammo:** 5 max. Pickups on levels (+1 or +2).
- **Noise:** Quiet. Audible to enemies within 3 tiles (96 px).
- **Reload:** Manual (press reload button) or auto when empty. 1.5 sec.

## EMP Grenade
- **Effect:** Drones within 150 px fall and disable for 10 sec.
- **Carry:** 3 max. Pickups on levels.
- **Throw:** Arc trajectory (parabola). Hold to show arc preview.
- **Noise:** 150 px on explosion.

## Smoke Bomb
- **Effect:** 100 px radius, 8 sec. Blocks vision.
- **Carry:** 2 max.
- **Throw:** Same as EMP.

## Decoy (Rock)
- **Effect:** Throw to point. On landing: 100 px noise for 2 sec.
- **Carry:** Infinite (1 active at a time; old one vanishes on new throw).

## Health
- **Max:** 3 hearts (6 [[GDD_Core_v2|HP]] if half-heart granularity, but use whole hearts).
- **Medkit:** +1 heart. Max 3.
- **Damage sources:** Enemy melee (1 heart), projectiles (1 heart), traps (1 heart), fall (instant death if > 5 tiles).
- **Invulnerability:** 1.0 sec after hit (blink).

---

## Связанные разделы

- [[Mechanics_Index]]
- [[MOC_02_GameDesign]]
- [[GDD_Core_v2]]
- [[Input_Map]]
