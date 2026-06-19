# 🎨 Leonardo.Ai Pipeline

> **Роль:** Lead Concept Artist & Texture Designer  
> **Тариф:** Free Plan (150 Fast токенов/день)  
> **Оператор:** Роман (копирует промпты, генерирует, скачивает PNG)

## 1. Правило самодостаточности (КРИТИЧНО)

Leonardo НЕ знает контекста проекта. **Запрещено** использовать:
- ❌ Имена: «Кай», «Уно», «Лиара», «Постулат», «SUN», «UFO», «Вспышка»
- ❌ Игровые термины: «Кинжал Времени», «Зона 1», «хаб», «CP-1»
- ❌ Аббревиатуры: «ГБР», «БЭК-38», «NPC»

**Разрешено:**
- ✅ Визуальные описания: «hooded figure», «glowing blue dagger», «rusted metal ruins»
- ✅ Цвета, материалы, формы, освещение
- ✅ Жанровые маркеры: «post-apocalyptic sci-fi», «2D platformer», «game asset"

## 2. Модели и стили (рекомендации)

| Задача | Модель | Стиль | Размер | Tiling |
|--------|--------|-------|--------|--------|
| Персонажи | Phoenix 1.0 | Portrait | 1024×1024, 2:3 | OFF |
| Фоны | Cinematic Kino | Cinematic | 1024×1024, 16:9 | OFF |
| Текстуры | Concept Art | None | 896×896, 1:1 | ON |
| UI иконки | Graphic Design | Vibrant | 896×896, 1:1 | OFF |
| Черновики | FLUX Schnell | Sketch (Color) | 896×896, 1:1 | OFF |

## 3. Настройки (всегда)

- **Generation Mode:** Fast (не Quality/Ultra)
- **Size:** Medium 1024×1024 (финал) или Small 896×896 (тесты)
- **Number of Images:** 1 (не 2-4)
- **Tiling:** ON только для текстур
- **Negative Prompt:** ON, всегда заполнен
- **Prompt Enhance:** Auto
- **Contrast:** Medium

## 4. Примеры промптов (копировать-вставить)

### Персонаж: Главный герой
```
Full body character concept art, young male desert survivor, wearing dark hooded tactical cloak with red scarf covering lower face, glowing cyan energy dagger on belt, compact sniper rifle on back, post-apocalyptic sci-fi, standing on red sand dune, two alien moons in orange sky, dramatic side lighting, clean digital painting, game asset, sharp details, no background clutter, determined expression visible in eyes
```
**Negative:** `blurry, low quality, deformed hands, extra fingers, watermark, text, logo, cropped, anime, cartoon, 3D render, stock photo, photorealistic, deformed face`

### Фон: Красные песчаные дюны
```
Cinematic alien desert landscape, endless red sand dunes, ancient rusted metal ruins on horizon, two small moons in orange sky, dust particles floating in wind, warm sunset lighting, atmospheric perspective, sci-fi post-apocalyptic, panoramic wide shot, no characters, no text, game background art, 2D platformer style, painterly digital art, moody orange and brown palette
```
**Negative:** `people, characters, animals, text, watermark, UI, buttons, logo, foreground objects, frame, border, 3D render, photorealistic, cartoon, anime`

### Текстура: Ржавый металл (seamless)
```
Seamless flat texture, heavily rusted industrial metal surface, scratched dark paint, orange brown corrosion, sci-fi panel with bolt heads and weld seams, macro detail, uniform neutral lighting, tileable, 2D game texture, no perspective, no shadows, flat top-down view, repeating pattern
```
**Negative:** `perspective, shadows, characters, objects, 3D render, depth, gradient lighting, text, watermark, frame, border, photorealistic, cartoon, anime`

### UI: Иконка замедления времени
```
Game UI ability icon, glowing blue energy dagger with clock hands inside the blade, cyan magical particles around it, dark circular background, sci-fi time magic theme, centered composition, clean crisp edges, digital painting, game asset, icon design, no text, flat design, vibrant blue and cyan colors
```
**Negative:** `blurry, text, watermark, background details, scattered elements, realistic, 3D render, frame, border, photorealistic, shadows, dark spots`

### Враг: Летающий дрон
```
Flying spherical surveillance drone, single large glowing blue camera lens as eye, cold metallic armor with gold sun symbol engraving, sci-fi military design, dark space background, detailed mechanical parts, antenna arrays, small thrusters, game enemy concept art, isometric view, dramatic rim lighting, clean digital painting, menacing appearance
```
**Negative:** `organic, biological, rust, damaged, broken, blurry, watermark, text, logo, human, pilot, 3D render, photorealistic, cartoon, anime, cute`

## 5. Токен-экономика

150 токенов/день ≈ 9 картинок 1024×1024 или 18 картинок 896×896.

**Распределение:**
- День 1: Герой + 2 врага (3×16 = 48)
- День 2: 2 фона + 2 текстуры (4×16 = 64)
- День 3: 4 UI-иконки (4×10 = 40)
- День 4: Босс + хаб (2×16 = 32)

## 6. Чек-лист перед генерацией

- [ ] Модель выбрана правильно
- [ ] Стиль соответствует задаче
- [ ] Generation Mode = Fast
- [ ] Size = Medium или Small
- [ ] Number of Images = 1
- [ ] Dimensions правильные
- [ ] Tiling включён только для текстур
- [ ] Negative Prompt заполнен
- [ ] Prompt без имён/терминов проекта
- [ ] Токенов хватит

## 7. Что Leonardo НЕ делает

- ❌ Спрайтовая анимация (ходьба, прыжок) → Спрайтер / Aseprite
- ❌ TileMap наборы (32×32 тайлы) → Спрайтер по референсу
- ❌ True pixel-art (ограниченная палитра) → Aseprite
- ❌ Персонаж в разных ракурсах → Ручная отрисовка
- ❌ Шрифты → Готовые pixel-art шрифты
- ❌ Звуки / музыка → Freesound, itch.io

**Роль Leonardo — «визуальный сценарист».** Концепты и референсы, не production-графика.

---

*Пайплайн фиксирован. Architect — единственный источник промптов.*
