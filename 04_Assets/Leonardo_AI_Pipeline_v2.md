# Leonardo.Ai Pipeline v2

## Status
Free Plan. 150 Fast Tokens/day. Public generations. No API.

## Recommended Models
| Task | Model | Tokens (1024) |
|------|-------|---------------|
| Player, NPCs, enemies | Phoenix 1.0 | ~16 |
| Bosses, key art, backgrounds | Cinematic Kino | ~16 |
| Textures, tiles, environments | Concept Art | ~10 |
| UI icons, HUD elements | Graphic Design | ~10 |
| Quick drafts, composition tests | FLUX Schnell | ~8 |

## Settings (always)
- Generation Mode: Fast
- Size: Medium (1024×1024) for final, Small (896×896) for tests/icons
- Number of Images: 1
- Prompt Enhance: Auto
- Contrast: Medium
- Negative Prompt: ON

## Prompt Rules
- NO names: "Kai", "SUN", "UFO", "Postulate", "Vspyshka", "Zone 1"
- YES: visual descriptions (hooded figure, glowing blue dagger, rusted metal ruins, two moons)
- YES: style markers (post-apocalyptic sci-fi, 2D platformer, game asset, pixel-art reference)

## Ready Prompts (copy-paste)

### Player Concept
```
Model: Phoenix 1.0 | Style: Portrait | Size: Medium | 2:3 | Tiling: OFF
Prompt: Full body character concept, young male desert survivor, dark hooded tactical cloak, red scarf covering lower face, glowing cyan energy dagger on belt, compact sniper rifle on back, post-apocalyptic sci-fi, standing on red sand dune, two alien moons in orange sky, dramatic side lighting, clean digital painting, game asset, sharp details, no background clutter, determined eyes visible
Negative: blurry, low quality, deformed hands, extra fingers, watermark, text, logo, cropped, anime, cartoon, 3D render, stock photo, photorealistic, deformed face
```

### Zone 1 Background
```
Model: Cinematic Kino | Style: Cinematic | Size: Medium | 16:9 | Tiling: OFF
Prompt: Cinematic alien desert landscape, endless red sand dunes, ancient rusted metal ruins on horizon, two small moons in orange sky, dust particles floating in wind, warm sunset lighting, atmospheric perspective, sci-fi post-apocalyptic, panoramic wide shot, no characters, no text, game background art, 2D platformer style, painterly digital art, moody orange and brown palette
Negative: people, characters, animals, text, watermark, UI, buttons, logo, foreground objects, frame, border, 3D render, photorealistic, cartoon, anime
```

### Rusty Metal Texture (seamless)
```
Model: Concept Art | Style: None | Size: Small | 1:1 | Tiling: ON
Prompt: Seamless flat texture, heavily rusted industrial metal surface, scratched dark paint, orange brown corrosion, sci-fi panel with bolt heads and weld seams, macro detail, uniform neutral lighting, tileable, 2D game texture, no perspective, no shadows, flat top-down view, repeating pattern
Negative: perspective, shadows, characters, objects, 3D render, depth, gradient lighting, text, watermark, frame, border, photorealistic, cartoon, anime
```

### Time Dagger Icon
```
Model: Graphic Design | Style: Vibrant | Size: Small | 1:1 | Tiling: OFF
Prompt: Game UI ability icon, glowing blue energy dagger with clock hands inside the blade, cyan magical particles around it, dark circular background, sci-fi time magic theme, centered composition, clean crisp edges, digital painting, game asset, icon design, no text, flat design, vibrant blue and cyan colors
Negative: blurry, text, watermark, background details, scattered elements, realistic, 3D render, frame, border, photorealistic, shadows, dark spots
```

### Sand Leviathan Boss
```
Model: Cinematic Kino | Style: Cinematic Concept | Size: Medium | 16:9 | Tiling: OFF
Prompt: Cinematic key art, colossal sand worm monster erupting from red dunes, multiple glowing blue eyes along body, armored metallic segments, massive scale dust storm, tiny hooded human figure in foreground for scale, sci-fi desert planet, dramatic sunset lighting, movie poster composition, game boss concept, no text, terrifying creature design
Negative: text, logo, watermark, UI, cartoon, anime, cute, small, blurry, 3D render, photorealistic, deformed, friendly
```

## Token Economy (150/day)
| Day | Tasks | Est. Tokens |
|-----|-------|-------------|
| 1 | Player + 2 enemies | ~48 |
| 2 | 2 backgrounds + 2 textures | ~40 |
| 3 | 4 UI icons | ~32 |
| 4 | Boss + Hub concept | ~32 |
| 5 | 2 NPCs + drafts | ~32 |

## What Leonardo DOES NOT Do
- Sprite animation (walk cycles) → Aseprite / manual
- True pixel-art (limited palette) → Aseprite / manual
- Fonts → Use M5x7 or Pixel Operator
- Sound → Freesound / itch.io
