# 🔊 Audio Design

> **Источники:** Freesound.org, itch.io (фри-ассеты)  
> **Формат:** OGG (музыка, амбиент), WAV (SFX)  
> **Godot:** `AudioStreamPlayer` (SFX), `AudioStreamPlayer` (Music), `AudioStreamPlayer` (Ambient)

## 1. Музыка (динамическая)

### Система
- 3 слоя музыки для каждой зоны: Exploration, Suspicious, Combat.
- Плавный переход между слоями (crossfade 2 сек).
- Godot: 3 `AudioStreamPlayer` с одинаковым треком, но разными миксами. `volume_db` меняется через `Tween`.

### Треки по зонам

| Зона | Exploration | Suspicious | Combat |
|------|-------------|------------|--------|
| Зона 1 (Дюны) | Этнические перкуссии, дудук, ветер | Та же, + тревожные струны | Барабаны, электрогитара, бас |
| Зона 2 (Оазис) | Синтвейв, холодные пэды, неоновые арпеджио | + пульсирующий бас | Техно, агрессивные синты |
| Зона 3 (Лабы) | Атмосферный дрон, металлические удары | + биение сердца | Индустриал, глитч, крики |
| Хаб | Тёплые аккорды, гитара, надежда | — | — |
| Боссы | Эпичный оркестр + синты | — | Интенсивный, ударные |

### Godot
```gdscript
# audio_manager.gd (часть)

@onready var music_exploration: AudioStreamPlayer = $MusicExploration
@onready var music_suspicious: AudioStreamPlayer = $MusicSuspicious
@onready var music_combat: AudioStreamPlayer = $MusicCombat

var _current_layer: String = "exploration"

func set_music_layer(layer: String) -> void:
    if _current_layer == layer: return
    _current_layer = layer
    var tween := create_tween().set_parallel()
    match layer:
        "exploration":
            tween.tween_property(music_exploration, "volume_db", 0.0, 2.0)
            tween.tween_property(music_suspicious, "volume_db", -80.0, 2.0)
            tween.tween_property(music_combat, "volume_db", -80.0, 2.0)
        "suspicious":
            tween.tween_property(music_exploration, "volume_db", -10.0, 2.0)
            tween.tween_property(music_suspicious, "volume_db", 0.0, 2.0)
            tween.tween_property(music_combat, "volume_db", -80.0, 2.0)
        "combat":
            tween.tween_property(music_exploration, "volume_db", -80.0, 2.0)
            tween.tween_property(music_suspicious, "volume_db", -10.0, 2.0)
            tween.tween_property(music_combat, "volume_db", 0.0, 2.0)
```

## 2. SFX (Sound Effects)

### Категории

| Категория | Звуки | Громкость |
|-----------|-------|-----------|
| **Player** | Шаги (бег/присед), прыжок, рывок, перекат, удар ножом, выстрел снайперки | 0 dB |
| **Enemies** | Дрон (жужжание), Страж (шаги брони), Тварь (рык), Снайпер (прицеливание) | -5 dB |
| **Environment** | Песок (шаги), металл (прыжок), лазер (гул), двери (скрип) | -10 dB |
| **UI** | Клик, hover, открытие меню, диалог (печать текста) | -15 dB |
| **Special** | Time Dagger (замедление звука), ЭМИ (вспышка), дым (шипение) | 0 dB |

### Важные SFX
- **Шаги:** Разные для бега (громкие, быстрые) и приседания (тихие, медленные).
- **Выстрел снайперки:** Тихий "пффф" + механический щелчок. Слышен в радиусе 3 метров (враги в радиусе 80 px переходят в Suspicious).
- **Time Dagger:** Обратный звук (rewind), низкий гул, тиканье часов.
- **Stealth Kill:** Тихий "хлюп" + звук падающего тела (мягкий).
- **Alert:** Звуковой сигнал (враг), гудок (тревога).

## 3. Ambient (Амбиент)

| Зона | Амбиент |
|------|---------|
| Зона 1 | Ветер, песок, далёкие механические звуки, крики птиц (вендучи) |
| Зона 2 | Холодный ветер, гул генераторов, неоновый жужжок, эхо |
| Зона 3 | Капли, гул машин, биение (сердце биомеханоида), электрические разряды |
| Хаб | Костёр, тихие голоса, металлические звуки, надежда |
| Боссы | Дрожание земли, рев, механические скрипы |

## 4. Голоса

- **Без полной озвучки.** Только текст + звуки-плейсхолдеры (бормотание, вздохи).
- **Кай:** Немой (как в Hollow Knight). Только звуки дыхания, ударов.
- **NPC:** Звуки-плейсхолдеры ("хм", "а-а", "хах") при диалогах.
- **Враги:** Роботизированные голоса дронов ("Обнаружен нарушитель"), рык Твари.

## 5. Godot Audio Buses

```
Master
├── Music (volume: 0 dB)
│   ├── Exploration
│   ├── Suspicious
│   └── Combat
├── SFX (volume: 0 dB)
│   ├── Player
│   ├── Enemies
│   ├── Environment
│   └── UI
└── Ambient (volume: -5 dB)
```

---

*Аудио — 50% атмосферы. Динамическая музыка, контекстные SFX.*
