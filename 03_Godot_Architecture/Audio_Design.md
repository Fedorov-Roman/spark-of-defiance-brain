# 🔊 Audio Design

> **Источники:** Freesound, itch.io (фри-ассеты)  
> **Форматы:** OGG (музыка, амбиент), WAV (SFX)  
> **Godot:** `AudioStreamPlayer`, `AudioStreamPlayer2D`, `AudioBus`

## 1. Аудио шины (Audio Buses)

| Шина | Назначение | Громкость по умолчанию |
|------|------------|------------------------|
| Master | Мастер | 0 dB |
| Music | Музыкальные треки | -5 dB |
| SFX | Звуки действий | 0 dB |
| Ambient | Фоновые звуки | -8 dB |
| UI | Звуки интерфейса | -3 dB |
| Voice | Диалоги (если будут) | 0 dB |

## 2. Музыка (динамическая)

### Система
- **Базовый трек:** Спокойная, атмосферная.
- **Тревога:** При Suspicious/Alert — плавный переход (crossfade 2 сек).
- **Бой:** При обнаружении — интенсивный трек.
- **Возврат:** После 10 сек спокойствия — возврат к базовому.

### Треки по зонам
| Зона | Базовый | Тревога | Бой |
|------|---------|---------|-----|
| Красные Дюни | Пустынная флейта, перкуссия | Струнные, напряжение | Электрогитара, барабаны |
| Полярный Оазис | Синтезатор, холодные пэды | Пульс, аналоговый синт | Техно, индустриальный |
| Глубинные Лабы | Эмбиент, эхо, низкие частоты | Дисторшн, глитч | Драм-н-бейс, агрессивный |
| Хаб | Акустическая гитара, тепло | — | — |
| Боссы | Оркестр + синтезатор | — | Хор, ударные, эпичность |

## 3. SFX (Sound Effects)

### Кай
| Действие | Звук |
|----------|------|
| Шаг (бег) | Песок/металл (зависит от поверхности) |
| Шаг (присед) | Тихий, приглушённый |
| Прыжок | Лёгкий вздох + свист воздуха |
| Wall-jump | Отскок, резкий |
| Рывок | Свист, разрыв воздуха |
| Перекат | Песок, кувырок |
| Удар ножом | Энергетический всплеск |
| Выстрел снайперки | Тихий пневматический выстрел |
| Попадание снайперки | Электрический разряд |
| Крюк-кошка | Механический щелчок + свист цепи |
| Получение урона | Вскрик, электрический шок |
| Смерть | Фейд, тишина |

### Враги
| Действие | Звук |
|----------|------|
| Дрон: обнаружение | Писк, повышение тона |
| Дрон: патруль | Жужжание, низкое |
| Страж: шаги | Тяжёлые ботинки, металл |
| Страж: тревога | Крик, рация |
| Кремневая Тварь: шаги | Скрежет кремния |
| Кремневая Тварь: атака | Рёв, каменный |
| Снайпер: прицеливание | Высокочастотный писк |
| Снайпер: выстрел | Глушитель — тихий хлопок |

### Окружение
| Событие | Звук |
|---------|------|
| Пыльная буря | Ревущий ветер, песок |
| Лазерная сетка | Жужжание, периодический щелчок |
| ЭМИ-взрыв | Электрический хлопок, тишина |
| Дымовая шашка | Шипение |
| Дверь (открытие) | Механический скрип |
| Чекпоинт | Мягкий звон |
| Дата-драйв (подбор) | Цифровой звук, пик |

## 4. Амбиент (фоновые звуки)

| Зона | Амбиент |
|------|---------|
| Красные Дюни | Ветер, далёкие грозы, песок |
| Полярный Оазис | Ветер, снег, далёкие машины |
| Глубинные Лабы | Гул генераторов, капли, электричество |
| Хаб | Костёр, шёпот, металл |
| Боссы | Сердцебиение, низкие частоты |

## 5. Godot Implementation

```gdscript
class_name AudioManager extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
@onready var ambient_player: AudioStreamPlayer = $AmbientPlayer

var _current_music: String = ""
var _current_ambient: String = ""
var _music_tween: Tween

func play_music(track: String, crossfade: float = 2.0) -> void:
    if _current_music == track: return
    _current_music = track

    # Crossfade out
    if _music_tween:
        _music_tween.kill()
    _music_tween = create_tween()
    _music_tween.tween_property(music_player, "volume_db", -80.0, crossfade)
    _music_tween.tween_callback(func():
        music_player.stream = load("res://assets/audio/music/" + track + ".ogg")
        music_player.play()
        music_player.volume_db = -80.0
        var tween2 := create_tween()
        tween2.tween_property(music_player, "volume_db", -5.0, crossfade)
    )

func play_sfx(sound: String, bus: String = "SFX") -> void:
    var player := AudioStreamPlayer.new()
    player.stream = load("res://assets/audio/sfx/" + sound + ".wav")
    player.bus = bus
    add_child(player)
    player.play()
    await player.finished
    player.queue_free()

func play_ambient(zone: String) -> void:
    if _current_ambient == zone: return
    _current_ambient = zone
    ambient_player.stream = load("res://assets/audio/ambient/" + zone + ".ogg")
    ambient_player.play()
```

## 6. Плейсхолдеры

До CP-13 (Art & Sound) используем:
- Музыка: 1 базовый трек (loop) для всех зон.
- SFX: Генераторы (Bfxr, LabChirp) или фри-ассеты с itch.io.
- Амбиент: Белый шум с фильтрами (Godot `AudioEffectFilter`).

---

*Аудио — 50% атмосферы. Динамическая музыка усиливает стелс.*
