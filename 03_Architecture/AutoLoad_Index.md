# AutoLoad Index
| # | Name | File | Purpose | Signals |
|---|------|------|---------|---------|
| 1 | GameState | [[03_Architecture/AutoLoad_Singletons_v2]] | Session data, zone flags | zone_loaded |
| 2 | SaveManager | [[03_Architecture/AutoLoad_Singletons_v2]] | JSON save/load | saved, loaded |
| 3 | ProgressionManager | [[03_Architecture/AutoLoad_Singletons_v2]] | NPCs, abilities, Data Drives | npc_rescued, ability_unlocked |
| 4 | InputManager | [[03_Architecture/AutoLoad_Singletons_v2]] | Dual input detection | device_changed |
| 5 | DialogueManager | [[03_Architecture/AutoLoad_Singletons_v2]] | Text boxes, portraits | dialogue_started, dialogue_finished |
| 6 | AudioManager | [[03_Architecture/AutoLoad_Singletons_v2]] | Music states, SFX | music_state_changed |
| 7 | TimeManager | [[03_Architecture/AutoLoad_Singletons_v2]] | Hybrid time scale | time_dagger_started, time_dagger_ended |
| 8 | UIManager | [[03_Architecture/AutoLoad_Singletons_v2]] | HUD, menus, pause | hud_updated |
| 9 | LevelManager | [[03_Architecture/AutoLoad_Singletons_v2]] | Zone transitions | zone_loaded |
