# Answers Bible
*Single source of truth for all 88 answered questions.*

## A. General & Scale
| # | Question | Answer |
|---|----------|--------|
| A1 | MVP or full? | Full game (3 zones + 3 bosses + final) |
| A2 | Timeline? | Unrushed; quality over speed |
| A3 | Format? | Portfolio (university) + indie release |
| A4 | Platform? | PC (Windows) |
| A5 | Input? | Gamepad + Keyboard/Mouse |
| A6 | Mobile? | No |
| A7 | Resolution? | Adaptive (base 640×360) |
| A8 | Tile size? | 32×32, pixel-perfect x2/x3 |
| A9 | Builder? | AI (DeepSeek v4 Pro) |
| A10 | Artist? | Placeholders first, then pixel-art (self/free assets) |
| A11 | Audio? | Free assets (Freesound, itch.io) |
| A12 | Time Dagger? | Hybrid: world 30%, Kai 100%, blue screen shader |
| A13 | Godot version? | 4.6.3 stable |

## B. Architecture & Systems
| # | Question | Answer |
|---|----------|--------|
| B1 | Levels? | TileMap (grid-based) |
| B2 | Mix? | Yes: TileMap for bg/walls, separate scenes for interactives/enemies |
| B3 | World map? | Full map (unlocks after rescuing Comms Officer) |
| B4 | Backtracking? | Yes, classic metroidvania loop |
| B5 | Saves? | Autosave at checkpoints |
| B6 | Save scope? | Full world state |
| B7 | Death respawn? | Last checkpoint |
| B8 | Hub? | One dynamic scene (NPCs appear/disappear by flags) |
| B9 | Git? | Yes |
| B10 | Folders? | Modular (entities/, systems/, scenes/, assets/) |
| B11 | Groups vs Signals? | Groups for physics/collision; Signals for logic & UI |
| B12 | Save format? | JSON (human-readable) |
| B13 | Loading screen? | Yes, with lore text |

## V. Physics & Movement
| # | Question | Answer |
|---|----------|--------|
| V1 | Wall-run? | Vertical wall-slide (auto on touch) |
| V2 | Wall-run trigger? | Automatic on wall contact |
| V3 | Wall-jump? | Changes direction (impulse side + up) |
| V4 | Dash directions? | 4 directions. Air dash once (resets on ground) |
| V5 | Roll i-frames? | 0.4 sec |
| V6 | Crouch effects? | Speed ↓, noise ↓, hitbox ↓ |
| V7 | Double jump? | Unlocked by Master Jaan (Air Dash) |
| V8 | Grapple? | Point-to-point, can hang and swing (pendulum physics) |
| V9 | Speed curve? | Fixed speed with smooth accel/decel ("juice") |
| V10 | Wall-slide? | Slows fall |
| V11 | Ledge grab? | Yes, can pull up |

## G. Gameplay & Stealth
| # | Question | Answer |
|---|----------|--------|
| G1 | Detection? | Gradient: Idle → Suspicious → Alert |
| G2 | HP? | 3 hearts, medkits in world |
| G3 | Alert decay? | Returns to patrol after 30 sec if Kai lost |
| G4 | Body discovery? | Yes |
| G5 | Stealth kills? | Single button |
| G6 | Sniper aim? | Button press in cursor direction |
| G7 | Sniper input? | Stick (mouse also works) |
| G8 | Ammo? | Limited, pickups on levels |
| G9 | Max ammo? | 5 |
| G10 | Paralyzed enemy? | Can knife kill |
| G11 | Knife kill angle? | Back only (or side if fully stunned) |
| G12 | Front knife? | Kai takes 1 damage, knocked back, enemy alerts |
| G13 | Drone Eye? | Flying, fixed waypoints |
| G14 | Guard SUN? | Ground patrol route |
| G15 | Silicon Beast? | Reacts to any sound (including decoys) |
| G16 | Elite Sniper? | Static on tower |
| G17 | Decoys? | Rock (infinite), 1 active at a time |
| G18 | Smoke? | Blocks line of sight (cones cut off) |
| G19 | EMP effect? | Drones fall and disable for 10 sec |
| G20 | Alarm timer? | Spawns 2 new enemies from hidden zones |
| G21 | Tall grass? | Hides only while crouching |
| G22 | Shadows? | Dynamic (LightOccluder2D) |

## D. Level Design & Zones
| # | Question | Answer |
|---|----------|--------|
| D1 | Dust storms? | Random events, 40–60 sec |
| D2 | Storm visibility? | Both sides reduced; Kai footsteps masked |
| D3 | Laser grids? | Disabled by EMP or switches only |
| D4 | Gravity anomalies? | Change direction (walk on ceiling/walls) |
| D5 | Leviathan arena? | Separate arena |
| D6 | Leviathan blind? | Environment mechanic (shoot steam valves) |
| D7 | Helios-7 arena? | Separate arena |
| D8 | Biomechanoid vulnerability? | Invincible without Time Dagger slow |
| D9 | Boss checkpoint? | Right before fight |
| D10 | Fast travel? | Only from discovered pads |
| D11 | Vspyshka flight? | Auto cutscene |
| D12 | Landing pads? | 7–10 total |
| D13 | Lock & key? | Yes (Dash, Grapple, EMP gates) |
| D14 | Secrets? | Free exploration (Data Drives) |
| D15 | Enemy respawn? | On zone re-entry |

## E. Narrative & Hub
| # | Question | Answer |
|---|----------|--------|
| E1 | Dialogues? | Text boxes with pixel portraits |
| E2 | Branching? | Linear |
| E3 | Quests? | Main line + small fetch tasks for Hub details |
| E4 | Side quest impact? | Rewards + visual Hub changes only |
| E5 | Repeat dialogue? | Yes (rotating lines) |
| E6 | NPC movement? | Static (save animation budget) |
| E7 | Upgrades cost? | Free, require Data Drives |
| E8 | Crafting? | No (module activation only) |
| E9 | Hub exit? | Via Vspyshka terminal |
| E10 | Uno's shop currency? | Data Drives |

## J. Story & Localization
| # | Question | Answer |
|---|----------|--------|
| J1 | Cameos? | Audio logs, mentions, documents (Perceval, Tadel, Pascal, Dallas) |
| J2 | Branching story? | Linear |
| J3 | Endings? | One ending |
| J4 | Language? | English |
| J5 | Text language? | English |
| J6 | Font? | M5x7 or Pixel Operator (Latin) |
| J7 | Cutscenes? | In-engine (camera moves, sprite emotions) |
| J8 | Prologue? | Text on black screen |
| J9 | Kai voice? | Silent protagonist |

## Z. UI & UX
| # | Question | Answer |
|---|----------|--------|
| Z1 | HUD? | Minimal (hearts, ammo, gadget icons). Inventory/map by button |
| Z2 | Vision cones visible? | Yes, semi-transparent |
| Z3 | Alert indicator? | "!" icon + sound cue |
| Z4 | Minimap? | Opens on Square button |
| Z5 | Tutorial? | Interactive hints in Zone 1 |
| Z6 | Pause? | Full pause menu |
| Z7 | Graphics settings? | Yes (basic) |
| Z8 | Rebind keys? | Yes |
| Z9 | Accessibility? | Text speed setting |
| Z10 | Text speed? | Character-by-character, skippable |

## I. Visuals & Animation
| # | Question | Answer |
|---|----------|--------|
| I1 | Sprite format? | SpriteSheets |
| I2 | Directions? | 4 (Left/Right flip) |
| I3 | Animation system? | AnimatedSprite2D first, then AnimationTree |
| I4 | Time shader? | Full-screen blue shader |
| I5 | Particles? | GPUParticles2D |
| I6 | Lighting? | Global darkness + lamps (PointLight2D) |
| I7 | Shadows? | Dynamic (LightOccluder2D) |
| I8 | Parallax? | Yes, 3 layers |
| I9 | Screen shake? | Yes |
| I10 | Noise visualization? | Yes, ripples from feet |
| I11 | Grapple line? | Dashed line |
| I12 | Death? | Fade to black, respawn |

## K. Audio
| # | Question | Answer |
|---|----------|--------|
| K1 | Footstep sounds? | Different for run / crouch |
| K2 | Music? | Dynamic (states) |
| K3 | Voice acting? | None (text + placeholder blips) |
| K4 | Sniper sound? | Quiet, audible within 3 meters |
| K5 | Ambient? | Yes, unique per zone |

## L. Production
| # | Question | Answer |
|---|----------|--------|
| L1 | Vertical slice? | No |
| L2 | Build frequency? | Every CP / sub-CP |
| L3 | Existing repo? | None (start from scratch) |
| L4 | File delivery? | Text & code in chat |
| L5 | Self-testing? | Yes (Roman can run Godot) |
| L6 | Documentation? | Brief comments in code + GDD |
| L7 | Min spec? | 60 FPS, any modern PC |
| L8 | Modding? | No |

---

## Связанные разделы

- [[MOC_00_Meta]]
- [[Decision_Log]]
- [[GDD_Core_v2]]
- [[Master_Plan_v2]]
