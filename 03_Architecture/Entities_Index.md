# Entities Index

Все игровые сущности (сцены) в проекте.

## Игрок
- [[player.gd]] / [[player.tscn]] — Кай (CharacterBody2D)
  - Компоненты: [[HealthComponent]], [[HitboxComponent]], [[HurtboxComponent]]

## Враги
- [[enemy_base.gd]] / [[enemy_base.tscn]] — базовый враг (State Machine)
  - Наследники: DroneEye, GuardSUN, SiliconBeast, EliteSniper (описаны в [[Enemies_Index]])

## NPC Хаба
- Описаны в [[Progression_and_Hub_v2]]

## Связанные разделы
- [[MOC_03_Architecture]] — вернуться к разделу
- [[MOC_06_Project]] — кодовая база
- [[Component_Pattern]] — компонентная архитектура
