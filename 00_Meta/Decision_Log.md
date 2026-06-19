# Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-06-19 | Godot 4.6.3 stable | Maintenance release, TileMapLayer improved, proven stable | All CP |
| 2026-06-19 | Hybrid Time Dagger (world 30%, Kai 100%) | A12 answer; global time_scale breaks UI | Custom delta system for "time_affected" group |
| 2026-06-19 | JSON save (full world state) | B12 answer; human-readable, easy debug | SaveManager design |
| 2026-06-19 | 640×360 base viewport | 32×32 tiles × 20×11 = 640×360; pixel-perfect x2/x3 | Camera, UI, parallax |
| 2026-06-19 | Gamepad primary, KB/M supported | A5 + note; sniper uses stick but mouse works | InputManager dual detection |
| 2026-06-19 | One dynamic Hub scene | B8 answer; NPCs visible/process by flags | ProgressionManager drives Hub |
| 2026-06-19 | Visible vision cones + dynamic shadows | G22 + Z2; Mark of the Ninja style | Performance risk: limit cone draw distance |
| 2026-06-19 | Pendulum grapple physics | V8 answer; custom physics for CharacterBody2D | Separate grapple module (~200 LOC) |
| 2026-06-19 | Gravity anomalies (arbitrary up_direction) | D4 answer; walk on ceiling/walls | Re-engineer wall-run/slide for dynamic up_direction |
| 2026-06-19 | English only, M5x7 font | J4-J6; pixel font with Latin support | All UI text |
| 2026-06-19 | Leonardo Free Plan: 150 tokens/day | Budget reality; concepts only, no animation | Art pipeline: placeholder → concept → final pixel-art |
