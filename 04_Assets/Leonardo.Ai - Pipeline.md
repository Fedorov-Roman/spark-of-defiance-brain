# Leonardo.Ai — Pipeline

> **Роль:** Lead Concept Artist & Texture Designer  
> **Тариф:** Free Plan (150 Fast Tokens/день)  
> **Оператор:** Роман (копирует промпты, генерирует, скачивает)  
> **Источник промптов:** Kimi (Architect) — единственный

---

## 1. Ограничения Free Plan (критично)

| Параметр | Значение | Как обходить |
|----------|----------|--------------|
| **Токены** | 150/день | Генерировать 1 картинку за раз, не 4. Планировать на неделю вперёд. |
| **Concurrent** | 1 | Не ставить в очередь несколько. |
| **Quality** | Только Fast | Не ждать Ultra. Fast достаточно для концептов. |
| **Size** | Medium 1024×1024 (финал), Small 896×896 (тесты) | Large (1120×1120) — платный. |
| **Публичность** | Все арты видны сообществу | Не генерировать NSFW, не использовать личные данные. |
| **Private Mode** | Недоступен | — |
| **Character Consistency** | Нет (LoRA платная) | Фиксировать seed (`Fixed Seed: ON`) для вариаций одного объекта. |

---

## 2. Модели и их назначение

| Модель | Для чего | Токены (1024×1024) | Рекомендация |
|--------|----------|---------------------|--------------|
| **Phoenix 1.0** | Персонажи, враги, NPC | ~16 | ⭐ Главная модель |
| **Cinematic Kino** | Фоны, боссы, key art | ~16 | ⭐ Для эпичных сцен |
| **Concept Art** | Текстуры, миры, атмосфера | ~10 | ⭐ Для tileable текстур |
| **Graphic Design** | UI, иконки, логотипы | ~10 | ⭐ Для HUD |
| **FLUX Schnell** | Черновики, тесты композиции | ~8 | Для быстрых набросков |
| **Illustrative Albedo** | Промо-арт, иллюстрации | ~16 | Для артов вне игры |

**Модели НЕ использовать:** Anime, Lifelike Vision, Portrait Perfect, Stock Photography, 3D Render — они не подходят под pixel-art / stylized sci-fi стиль игры.

---

## 3. Стили и их применение

| Стиль | Для чего | Когда использовать |
|-------|----------|-------------------|
| **Portrait** | Персонажи (фронт, фулбоди) | Для концептов Кая, NPC, врагов |
| **Cinematic Concept** | Боссы, обложка, титульный экран | Для key art, Steam-страницы |
| **Cinematic** | Фоны, пейзажи, драматичное освещение | Для parallax-фонов |
| **Dynamic** | Экшн-позы, движение | Для промо-скриншотов |
| **Moody** | Тёмные локации, хаб, лаборатории | Для ночных/подземных сцен |
| **Vibrant** | UI, иконки, энергетические эффекты | Для HUD иконок |
| **None** | Чистые материалы, без стилизации | Для seamless текстур (Tiling: ON) |
| **Macro** | Текстуры, крупный план материалов | Для tileable поверхностей |
| **Sketch (Color)** | Быстрые цветные наброски | Для тестов композиции |

---

## 4. Настройки интерфейса (чек-лист)

**Всегда ставить так:**

- [ ] **Generation Mode:** Fast (не Quality/Ultra)
- [ ] **Dimensions:** 1:1 (иконки/текстуры), 2:3 (персонажи), 16:9 (фоны)
- [ ] **Size:** Medium 1024×1024 (финал) или Small 896×896 (тесты/иконки)
- [ ] **Number of Images:** 1 (не 2-4, это платно)
- [ ] **Tiling:** ON для текстур / OFF для персонажей/фонов
- [ ] **Fixed Seed:** ON если нужна консистентность / OFF для вариаций
- [ ] **Negative Prompt:** ON и заполнен
- [ ] **Prompt Enhance:** Auto
- [ ] **Contrast:** Medium (по умолчанию)
- [ ] **Private Mode:** OFF (недоступен на Free)

---

## 5. Правило самодостаточности (КРИТИЧНО)

Leonardo **НЕ знает** контекста проекта. В промпте **запрещено** использовать:

- ❌ Имена: Кай, Уно, Лиара, Джаан, Элия, Кесс, Финч
- ❌ Фракции: SUN, UFO, Постулат
- ❌ Термины: Вспышка, Кинжал Времени, Зона 1, Хаб, CP-1
- ❌ Аббревиатуры: ГБР, БЭК-38

**Разрешено** использовать:

- ✅ Визуальные описания: hooded figure, glowing blue dagger, rusted metal ruins
- ✅ Цвета: cyan, orange, dark grey, crimson red
- ✅ Материалы: rusted steel, cracked concrete, glowing crystal
- ✅ Жанры: post-apocalyptic sci-fi, 2D platformer, game asset, pixel-art style
- ✅ Настроение: menacing, mysterious, epic, desolate

---

## 6. Примеры промптов (готовые к копированию)

### 6.1. Главный герой (Кай)

```
Модель: Phoenix 1.0
Стиль: Portrait
Размер: Medium 1024×1024
Dimensions: 2:3
Tiling: OFF
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Full body character concept art, young male desert survivor, wearing dark hooded tactical cloak with red scarf covering lower face, glowing cyan energy dagger on belt, compact sniper rifle on back, post-apocalyptic sci-fi, standing on red sand dune, two alien moons in orange sky, dramatic side lighting, clean digital painting, game asset, sharp details, no background clutter, determined expression visible in eyes, stylized not realistic

NEGATIVE PROMPT:
blurry, low quality, deformed hands, extra fingers, watermark, text, logo, cropped, anime, cartoon, 3D render, stock photo, photorealistic, deformed face, ugly, duplicate, mutated, out of frame, bad anatomy
```

### 6.2. Красные дюны (фон Зоны 1)

```
Модель: Cinematic Kino
Стиль: Cinematic
Размер: Medium 1024×1024
Dimensions: 16:9
Tiling: OFF
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Cinematic alien desert landscape, endless red sand dunes, ancient rusted metal ruins on horizon, two small moons in orange sky, dust particles floating in wind, warm sunset lighting, atmospheric perspective, sci-fi post-apocalyptic, panoramic wide shot, no characters, no text, game background art, 2D platformer style, painterly digital art, moody orange and brown palette, stylized not realistic

NEGATIVE PROMPT:
people, characters, animals, text, watermark, UI, buttons, logo, foreground objects, frame, border, 3D render, photorealistic, cartoon, anime, cute, modern buildings, cars
```

### 6.3. Ржавый металл (seamless тайл)

```
Модель: Concept Art
Стиль: None
Размер: Small 896×896
Dimensions: 1:1
Tiling: ON
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Seamless flat texture, heavily rusted industrial metal surface, scratched dark paint, orange brown corrosion, sci-fi panel with bolt heads and weld seams, macro detail, uniform neutral lighting, tileable, 2D game texture, no perspective, no shadows, flat top-down view, repeating pattern, pixel-art style, stylized not realistic

NEGATIVE PROMPT:
perspective, shadows, characters, objects, 3D render, depth, gradient lighting, text, watermark, frame, border, photorealistic, cartoon, anime, cracks, holes
```

### 6.4. Иконка "Кинжала Времени"

```
Модель: Graphic Design
Стиль: Vibrant
Размер: Small 896×896
Dimensions: 1:1
Tiling: OFF
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Game UI ability icon, glowing blue energy dagger with clock hands inside the blade, cyan magical particles around it, dark circular background, sci-fi time magic theme, centered composition, clean crisp edges, digital painting, game asset, icon design, no text, flat design, vibrant blue and cyan colors, stylized not realistic

NEGATIVE PROMPT:
blurry, text, watermark, background details, scattered elements, realistic, 3D render, frame, border, photorealistic, shadows, dark spots, gradient background
```

### 6.5. Дрон-наблюдатель (враг)

```
Модель: Phoenix 1.0
Стиль: Portrait
Размер: Medium 1024×1024
Dimensions: 1:1
Tiling: OFF
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Flying spherical surveillance drone, single large glowing blue camera lens as eye, cold metallic armor with gold sun symbol engraving, sci-fi military design, dark space background, detailed mechanical parts, antenna arrays, small thrusters, game enemy concept art, isometric view, dramatic rim lighting, clean digital painting, menacing appearance, stylized not realistic

NEGATIVE PROMPT:
organic, biological, rust, damaged, broken, blurry, watermark, text, logo, human, pilot, 3D render, photorealistic, cartoon, anime, cute, friendly
```

### 6.6. Песчаный червь (босс)

```
Модель: Cinematic Kino
Стиль: Cinematic Concept
Размер: Medium 1024×1024
Dimensions: 16:9
Tiling: OFF
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Cinematic key art, colossal sand worm monster erupting from red dunes, multiple glowing blue eyes along body, armored metallic segments, massive scale dust storm, tiny hooded human figure in foreground for scale, sci-fi desert planet, dramatic sunset lighting, movie poster composition, game boss concept, no text, terrifying creature design, stylized not realistic

NEGATIVE PROMPT:
text, logo, watermark, UI, cartoon, anime, cute, small, blurry, 3D render, photorealistic, deformed, friendly, dragon, snake, worm with legs
```

### 6.7. Черновик (быстрый тест)

```
Модель: FLUX Schnell
Стиль: Sketch (Color)
Размер: Small 896×896
Dimensions: 1:1
Tiling: OFF
Fixed Seed: OFF
Negative Prompt: ON
Prompt Enhance: Auto

PROMPT:
Color sketch, alien polar oasis with glowing neon trees, frozen ice lake, crashed metal spaceship wreck, sci-fi outpost buildings, rough composition, concept art, painterly, no fine details, blue and purple palette with orange accents, stylized not realistic

NEGATIVE PROMPT:
text, watermark, logo, 3D render, photorealistic, detailed, characters, people, frame, border
```

---

## 7. Токен-экономика (стратегия)

### Распределение 150 токенов/день (пример недели):

| День | Задачи | Модели | Токены | Картинки |
|------|--------|--------|--------|----------|
| **1** | Герой + 2 врага | Phoenix 1.0 ×3 | ~48 | 3 |
| **2** | 2 фона + 2 текстуры | Cinematic Kino + Concept Art | ~40 | 4 |
| **3** | 4 UI-иконки | Graphic Design ×4 | ~32 | 4 |
| **4** | Босс + Хаб-концепт | Cinematic Kino + Concept Art | ~32 | 2 |
| **5** | 2 NPC + тесты | Phoenix 1.0 + FLUX Schnell | ~32 | 3 |
| **6** | Резерв / доработка | Любая | ~16 | 1 |
| **7** | Резерв / доработка | Любая | ~16 | 1 |

**Запас есть.** Если результат не подходит — не переделывать сразу, а скорректировать промпт на следующий день.

---

## 8. Что Leonardo НЕ делает (и кто делает вместо неё)

| Задача | Leonardo | Кто делает |
|--------|----------|------------|
| Спрайтовая анимация (ходьба, прыжок) | ❌ Нет консистентности кадров | Спрайтер / Aseprite (ручная работа) |
| TileMap наборы (32×32 тайлы) | ❌ Нет идеального seamless | Спрайтер / Aseprite по референсу |
| True pixel-art (ограниченная палитра) | ❌ Anti-aliased, миллионы цветов | Спрайтер / Aseprite |
| Персонаж в разных ракурсах | ❌ Каждый ракурс — новый персонаж | Спрайтер / ручная отрисовка |
| Шрифты | ❌ Текст кривит | Готовые pixel-art шрифты (M5x7, Pixel Operator) |
| Звуки / музыка | ❌ | Композитор / фри-ассеты |

**Роль Leonardo — «визуальный сценарист».** Она создаёт атмосферу, внешность, мир. Но рутинная графика требует ручной работы или покупки готовых ассетов.

---

## 9. Интеграция с Godot

- **Формат:** PNG (прозрачность сохраняется)
- **Размеры:** 1024×1024 для фонов, 512×512 или 896×896 для текстур, 256×256 или 512×512 для UI
- **Пиксель-арт:** Leonardo выдаёт high-res. Нужен даунскейл + индексация цветов в Aseprite/GIMP до 32×32
- **Seamless:** Текстуры с Tiling=ON всё равно требуют проверки в Godot (TileMap) — возможны артефакты на стыках
- **Parallax:** Фоны 16:9 разрезаются на слои в Godot (ParallaxBackground + ParallaxLayer)
- **UI:** Иконки импортируются с Filter = Nearest (для чёткости при масштабировании)

---

## 10. Чек-лист перед каждой генерацией

- [ ] **Модель** выбрана правильно (Phoenix/Cinematic Kino/Concept Art/Graphic Design/FLUX Schnell)
- [ ] **Стиль** соответствует задаче
- [ ] **Generation Mode = Fast** (не Quality/Ultra)
- [ ] **Size = Medium или Small** (не Large)
- [ ] **Number of Images = 1** (не 2-4)
- [ ] **Dimensions** правильные (1:1 / 2:3 / 16:9)
- [ ] **Tiling** включён только для текстур
- [ ] **Negative Prompt** включён и заполнен
- [ ] **Prompt** не содержит имён персонажей/фракций/игровых терминов
- [ ] **Prompt** содержит: кто/что, внешность, цвета, окружение, освещение, стиль, назначение
- [ ] **Токенов хватит** (проверить остаток: 150 — текущий расход)

---

*Пайплайн зафиксирован. Промпты обновляются при необходимости через Kimi.*
