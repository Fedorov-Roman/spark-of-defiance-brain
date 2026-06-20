# Godot Architecture

## Renderer
- **GL Compatibility** — единственный вариант для pixel-perfect 2D в Godot 4.x
- Mobile/Forward+ дают субпиксельные артефакты при integer scaling
- NEAREST filter обязателен для всех canvas текстур

## Scene Tree Philosophy
Everything is a scene. Player, enemy, UI element, level — all `.tscn` files.

## Key Nodes
- `CharacterBody2D` — Player, enemies (manual physics).
- `Area2D` — Triggers, vision cones, noise detection.
- `RayCast2D` — Line of sight checks.
- `TileMapLayer` — Zone geometry (Godot 4.6+).
- `PointLight2D` + `LightOccluder2D` — Dynamic lighting.
- `GPUParticles2D` — Dust, sparks, smoke.

## Physics Layers
| Layer | Purpose |
|-------|---------|
| 1 | Player |
| 2 | Enemies |
| 3 | World/Static |
| 4 | Traps |
| 5 | Collectibles |
| 6 | Trigger Zones |
| 7 | Projectiles |
| 8 | Cover/Grass |
| 9 | UI |
| 10 | Particles |
| 11 | Grapple Points |
| 12 | Boss Weak Points |

## Up
[[MOC_03_Architecture]]
