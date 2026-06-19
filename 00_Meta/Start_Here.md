# 🚀 Start Here

**Проект:** Spark of Defiance  
**Движок:** Godot 4.6.3 Stable (2D Pixel-Art)  
**Жанр:** Stealth-Platformer + Metroidvania  
**Роли:** Kimi (Architect), DeepSeek v4 Pro (Primary Builder), Leonardo.Ai (Concept Artist), DeepSeek Flash / Qwen 3.7 Max (Reserve).  

---

## 📂 Навигация по Vault

| Папка | Содержимое |
|-------|------------|
| `00_Meta/` | Точка входа, онбординг, команда, манифест |
| `01_Universe/` | Лор, фракции, планеты, персонажи вселенной «Kill a Horse of Freedom» |
| `02_GameDesign/` | GDD, механики, уровни, враги |
| `03_Godot_Architecture/` | Структура проекта, сцены, AutoLoad, сигналы, Input Map, Save System |
| `04_Assets_and_Art/` | Пайплайн арта, Leonardo.Ai, аудио, плейсхолдеры |
| `05_Production/` | Master Plan, CP-Tracker, риски, решения |
| `99_Templates/` | Шаблоны ТЗ, запросов арта, ревью |

---

## 🎯 Быстрый старт для нового чата

**Если вы Kimi (Architect) в новом чате:** скопируйте содержимое `[[New_Chat_Onboarding]]` целиком в системный промпт.  
**Если вы Builder в новом чате:** скопируйте `[[New_Chat_Onboarding]]` + `[[CP-0_Project_Setup]]` или актуальный CP.  
**Если вы Роман:** откройте `[[Master_Plan]]` для текущего статуса.

---

## 🔑 Ключевые решения (зафиксировано)

- **Масштаб:** Полная игра (3 зоны + 3 босса + хаб + финал).
- **Платформа:** PC (Windows), геймпад + клавиатура/мышь.
- **Графика:** 32×32 тайлы, pixel-perfect масштаб x2/x3, placeholder → pixel-art.
- **Версия Godot:** 4.6.3 Stable (проверена, существует).
- **Структура:** Модульная (`entities/`, `systems/`, `scenes/`, `assets/`).
- **Сохранение:** JSON, полное состояние мира, автосейвы на чекпоинтах.
- **Язык:** Английский (текст + UI).
- **Локализация:** Только английский для MVP.
- **Контроль:** Git используется.

---

## 📞 Протокол эскалации

1. **Primary Builder (DeepSeek Pro)** застрял на 3 итерациях ревью → Architect переключает задачу на **Reserve Builder (DeepSeek Flash)**.
2. **Architect (Kimi)** не может выбрать паттерн → запрашивает **Reserve Architect (Qwen 3.7 Max)**.
3. **Reserve** не пишет код в проект без явного ТЗ от Architect'а. Только анализ, черновики, тулзы.

---

*Последнее обновление: 2026-06-19*  
*Версия мозга: 2.0 Full Context*
