# Art Conventions

## Pixel-Art Specs
- **Tile size:** 32×32
- **Base viewport:** 640×360 (20×11 tiles)
- **Scale:** x2 (1280×720) or x3 (1920×1080)
- **Filter:** NEAREST (no anti-aliasing)
- **Palette:** Limited (max 32 colors per sprite)

## Sprite Formats
- **Player:** 32×48 px (2 tiles tall), 4 directions (L/R flip)
- **Enemies:** 32×32 or 32×48
- **Bosses:** up to 128×128
- **Tiles:** 32×32, seamless for textures
- **UI icons:** 32×32 or 64×64
- **Portraits:** 64×64 (dialogue)

## Animation
- **System:** AnimatedSprite2D (start) → AnimationTree (later)
- **Frame rate:** 12 FPS for gameplay, 24 FPS for cutscenes
- **SpriteSheets:** Horizontal strips, frame size labeled

## Pipeline
1. Leonardo concept → reference PNG
2. Aseprite / manual pixel-art from reference
3. Export SpriteSheet (PNG)
4. Import to Godot with NEAREST filter
5. Place in `assets/art/final/`

## Color Palette (suggested)
- Kai: dark blue cloak, red scarf, cyan glow
- SUN: white/chrome, red visor, gold accents
- UFO: red, black, silver
- Environment: rust orange, sand brown, ruin gray
- UI: cyan, white, dark gray
