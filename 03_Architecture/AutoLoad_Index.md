# AutoLoad Index

Все глобальные синглтоны (AutoLoad) в проекте.

## Синглтоны (9 штук)
- [[game_state.gd]] — глобальное состояние игры (HP, патроны, позиция)
- [[save_manager.gd]] — JSON-сохранение/загрузка, автосейвы
- [[progression_manager.gd]] — флаги прогресса, NPC, способности
- [[time_manager.gd]] — кастомное замедление времени (группа "time_affected")
- [[audio_manager.gd]] — динамическая музыка, SFX, амбиенты
- [[dialogue_manager.gd]] — система диалогов, портреты, текст
- [[input_manager.gd]] — абстракция ввода (геймпад + клавиатура)
- [[level_manager.gd]] — переходы между зонами, загрузочный экран
- [[ui_manager.gd]] — управление UI-экранами (HUD, меню, карта)

## Связанные разделы
- [[AutoLoad_Singletons_v2]] — полный код каждого синглтона
- [[MOC_03_Architecture]] — вернуться к разделу
- [[MOC_06_Project]] — файлы в `systems/autoload/`
