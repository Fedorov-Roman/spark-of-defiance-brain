# 🖥️ UI/UX System

> **Godot:** `CanvasLayer` + `Control` ноды + `Theme`  
> **Шрифт:** M5x7 или Pixel Operator (пиксельный, латиница)  
> **Язык:** Английский  
> **Стиль:** Минималистичный в игре, полный в меню

## 1. HUD (Heads-Up Display)

### Элементы (всегда видны)
- **HP:** 3 сердца (Sprite2D, 16×16 каждое). Пустые = серые, полные = красные.
- **Энергия Кинжала:** Горизонтальная полоса (синяя), под HP. 100 единиц.
- **Боеприпасы снайперки:** Иконка патрона + число (0-5). В правом верхнем углу.
- **Гаджеты:** 3 иконки (ЭМИ, дым, приманка) + cooldown индикаторы (круговые).
- **Дата-драйвы:** Иконка + число (левый нижний угол).

### Расположение (CanvasLayer)
```
┌─────────────────────────────────────┐
│ [❤❤❤]  [███████]        [🔫 3/5] │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│ [💾 12]              [⚡] [💨] [🪨]│
└─────────────────────────────────────┘
```

## 2. Меню паузы

### Структура (Control)
- **Продолжить** (Resume)
- **Настройки** (Settings)
  - Графика: Разрешение, Полный экран/Окно, V-Sync
  - Управление: Input Map (переназначение клавиш/геймпада)
  - Аудио: Музыка, SFX, Амбиент (ползунки 0-100%)
  - Игра: Скорость текста (медленно/нормально/быстро)
- **Сохранить и выйти** (Save & Quit)

## 3. Диалоговое окно

### Визуал
- Пиксельная рамка (9-patch `StyleBoxTexture`).
- Портрет NPC слева (64×64, пиксель-арт).
- Текст справа (посимвольная печать).
- Имя NPC сверху (жёлтый цвет).
- Индикатор "▼" мигает, когда текст закончился.

### Управление
- **A / Крестовина / ЛКМ:** Продолжить/пропустить.
- **B / Круг:** Пропустить всё.

### Godot
```gdscript
class_name DialogueBox extends Control

@export var text_speed: float = 0.05  # сек/символ
@export var portrait_texture: Texture2D

@onready var portrait: TextureRect = $Portrait
@onready var name_label: Label = $NameLabel
@onready var text_label: Label = $TextLabel
@onready var continue_indicator: Sprite2D = $ContinueIndicator
@onready var type_timer: Timer = $TypeTimer

var _current_text: String = ""
var _current_index: int = 0
var _is_typing: bool = false

func show_dialogue(speaker: String, text: String) -> void:
    name_label.text = speaker
    _current_text = text
    _current_index = 0
    text_label.text = ""
    _is_typing = true
    type_timer.start(text_speed)
    visible = true

func _on_type_timer_timeout() -> void:
    if _current_index < _current_text.length():
        text_label.text += _current_text[_current_index]
        _current_index += 1
        type_timer.start(text_speed)
    else:
        _is_typing = false
        continue_indicator.visible = true
        type_timer.stop()

func _input(event: InputEvent) -> void:
    if not visible: return
    if event.is_action_pressed("interact"):
        if _is_typing:
            # Пропустить печать
            text_label.text = _current_text
            _current_index = _current_text.length()
            _is_typing = false
            continue_indicator.visible = true
            type_timer.stop()
        else:
            # Закрыть или следующая реплика
            DialogueManager.next_line()
```

## 4. Карта мира

### Открытие
- По кнопке "M" / Select (геймпад).
- Доступна после спасения Связиста Финча.

### Визуал
- Пиксельная карта (разведанные зоны — цветные, неразведанные — серые).
- Точки: хаб (зелёная), зоны (оранжевые), посадочные площадки (синие).
- Курсор — стрелка. Перемещение стиком/стрелками.
- Выбор точки + A = быстрое перемещение (если "Вспышка" доступна).

## 5. Инвентарь

### Открытие
- По кнопке "Tab" / D-Pad вниз (удержание).

### Содержимое
- Список гаджетов (иконка + название + количество).
- Описание при наведении.
- Нельзя выбрать — только информация.

## 6. Загрузочный экран

- **Между зонами:** Чёрный экран с текстом лора (рандомная цитата из вселенной).
- **Прогресс:** Пиксельная полоса внизу.
- **Длительность:** 1-2 секунды (асинхронная загрузка).

## 7. Game Over

- **Смерть:** Фейд в чёрный (0.5 сек).
- **Экран:** "YOU DIED" пиксельным шрифтом.
- **Опции:** "Retry" (у чекпоинта), "Quit to Hub".
- **Автосейв:** Перед респауном.

---

*UI — лицо игры. Минимализм в бою, полнота в меню.*
