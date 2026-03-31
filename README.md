# Tomato Brothers (番茄兄弟)

A 2D top-down survivor roguelike game inspired by Brotato (土豆兄弟), built with Godot Engine 4.3.

## Game Features

- **Wave-based Survival**: Survive 20 waves of increasingly difficult enemies
- **Auto-attack Combat**: Weapons fire automatically at nearby enemies
- **Character Progression**: Level up and choose upgrades between waves
- **Multiple Stats**: Health, Armor, Luck, Attack Speed, Damage, Crit Chance, and more
- **Pixel Art Style**: Classic 16-bit inspired pixel art aesthetic

## Controls

| Key | Action |
|-----|--------|
| W / ↑ | Move Up |
| S / ↓ | Move Down |
| A / ← | Move Left |
| D / → | Move Right |
| ESC | Pause |

## Project Structure

```
tomato-bro/
├── scenes/          # Godot scene files (.tscn)
│   ├── main/        # Main game scene
│   ├── player/      # Player character
│   ├── enemies/     # Enemy types
│   ├── weapons/     # Weapon systems
│   └── ui/          # UI scenes
├── scripts/         # GDScript files
│   ├── autoload/    # Global singletons
│   ├── entities/    # Player, Enemy, Pickup
│   ├── weapons/     # Weapon and projectile logic
│   ├── ui/          # UI controllers
│   └── resources/   # Custom resources
├── assets/          # Game assets
│   ├── sprites/     # Pixel art sprites
│   └── audio/       # Sound effects and music
└── resources/       # Game data resources
```

## Development Status

- [x] Project setup and configuration
- [x] Player movement and stats system
- [x] Enemy spawning and AI
- [x] Weapon system (base framework)
- [x] Level up and upgrade system
- [x] HUD and UI
- [x] Wave management
- [ ] Multiple weapon types
- [ ] Shop system
- [ ] Multiple character classes
- [ ] Sound effects and music
- [ ] Polish and visual effects

## Requirements

- **Godot Engine**: 4.3 or later (Mono version recommended)
- **Platform**: Windows, macOS, Linux

## How to Run

1. Install Godot Engine 4.3+ from https://godotengine.org/
2. Open Godot and import this project
3. Press F5 to run the game

## GitHub Setup

This is a private repository. To clone:

```bash
git clone git@github.com:YOUR_USERNAME/tomato-bro.git
cd tomato-bro
```

## License

All rights reserved. This is a fan project inspired by Brotato.

## Credits

- Original Inspiration: Brotato by Blobfish
- Engine: Godot Engine (MIT License)
