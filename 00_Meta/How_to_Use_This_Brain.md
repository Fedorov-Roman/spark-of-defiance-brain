# How to Use This Brain

Инструкция для Романа по работе с Obsidian Vault «Spark of Defiance».

## 1. Obsidian: первый запуск
1. Установите Obsidian (https://obsidian.md)
2. Откройте папку `spark-of-defiance-brain/` как Vault
3. Включите: Settings → Files and links → Use [[Wikilinks]]
4. Откройте граф: Ctrl+G (или Cmd+G) — вы увидите связи между файлами
5. Начните с [[Index]] или [[Start_Here]]

## 2. Для нового чата с Kimi (Architect)
1. Откройте [[New_Chat_Onboarding]]
2. Скопируйте содержимое целиком
3. Вставьте в новый чат первым сообщением
4. Добавьте контекст текущего CP (например: «Сейчас работаем над CP-1»)
5. Kimi мгновенно получит полный контекст проекта, роли, архитектуру и статус

## 3. Для работы с Builder (DeepSeek Pro)
1. Kimi выдаёт ТЗ в формате [[CP_Template]] (конкретный CP-N)
2. Вы копируете ТЗ в чат Builder'а
3. Builder возвращает код (файлы `.gd`, `.tscn`, `.tres`)
4. Вы показываете код Kimi для ревью (вставляете текст или описываете файлы)
5. Kimi проводит ревью по [[Code_Review_Template]] (KP/NC)
6. Builder исправляет KP → повторное ревью → принятие

## 4. Для Leonardo.Ai (арт)
1. Kimi пишет промпт в формате [[Asset_Request_Template]]
2. Вы копируете промпт в Leonardo.Ai
3. Настраиваете: Model (Phoenix 1.0 / Cinematic Kino / Concept Art / Graphic Design), Style, Size
4. Генерируете, скачиваете PNG
5. Кладёте в `06_Project/assets/art/leonardo/` (или другую папку по указанию Kimi)
6. Сообщаете Kimi — он обновляет [[Asset_Inventory]]
7. **Важно:** Leonardo не знает имён персонажей/фракций. Используйте только визуальные описания из промпта.

## 5. Для Godot (тестирование)
1. Откройте `06_Project/project.godot` в Godot 4.6.3
2. Работайте в папке `06_Project/`
3. Не редактируйте `.godot/` и `*.tmp` — они генерируются автоматически
4. Коммитьте через GitHub Desktop или терминал:
   ```bash
   git add .
   git commit -m "CP-X: описание"
   git push
   ```
5. Для теста запускайте `test_movement.tscn` или текущую рабочую сцену

## 6. Ежедневная работа
- Открывайте [[Daily_Notes_Template]] — ведите журнал сессии
- Проверяйте [[Bug_Tracker]] — добавляйте найденные баги
- Следите за [[Master_Plan_v2]] — понимайте, где вы находитесь
- Обновляйте [[Asset_Inventory]] при получении новых артов

## 7. Если что-то сломалось
- Проверьте [[Risk_Register]] — возможно, риск уже известен
- Запишите в [[Bug_Tracker]]
- Обратитесь к Kimi с контекстом из [[New_Chat_Onboarding]]
- При архитектурном тупике — Kimi может эскалировать на Qwen 3.7 Max

## 8. Структура папок (кратко)
- `00_Meta/` — управление, команда, решения
- `01_Universe/` — лор, фракции, планеты, персонажи
- `02_GameDesign/` — механики, уровни, враги, боссы, UI, звук
- `03_Architecture/` — Godot, сцены, AutoLoad, CP, паттерны
- `04_Assets/` — Leonardo, арт-конвенции, звуковой бриф
- `05_Production/` — план, CP-трекер, шаблоны, баги
- `06_Project/` — рабочий код Godot (`.gd`, `.tscn`, `.godot`)
- `99_Templates/` — шаблоны для ТЗ, ревью, онбординга
