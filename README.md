# Tomato Brothers (番茄兄弟)

A 2D top-down survivor roguelike game inspired by Brotato (土豆兄弟), built with Godot Engine 4.3.

## Game Features

- **Wave-based Survival**: Survive 20 waves of increasingly difficult enemies
- **Auto-attack Combat**: Weapons fire automatically at nearby enemies
- **Dual Weapon System**: Equip up to 2 weapons (1 for Solo)
- **9 Unique Characters**: Choose from different playstyles
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
| V | Toggle 2x Wave Speed |
| ESC | Pause |

## Characters

| Character | HP | Speed | Armor | Luck | Damage | ATK SPD | Crit | Special |
|-----------|-----|-------|-------|------|--------|---------|------|---------|
| 🍅 **Tomato** | 100 | 200 | 0 | 0% | 100% | 100% | 0% | Balanced |
| ⚔️ **Warrior** | 140 | 180 | 10 | 0% | 110% | 90% | 0% | Tanky starter |
| 🏹 **Ranger** | 80 | 220 | 0 | 20% | 90% | 130% | 5% | High ATK SPD |
| 🔮 **Mage** | 60 | 190 | 0 | 5% | 140% | 100% | 10% | Glass cannon |
| 🛡️ **Tank** | 200 | 150 | 20 | 0% | 90% | 80% | 0% | +0.5 HP/s regen |
| 🗡️ **Assassin** | 75 | 240 | 0 | 10% | 100% | 115% | 15% | 3x Crit mult |
| 🚀 **Rocketeer** | 90 | 195 | 5 | 5% | 120% | 100% | 5% | Starts with Rocket |
| 🎯 **Sniper** | 70 | 200 | 0 | 15% | 110% | 85% | 20% | Starts with Sniper |
| 💜 **Solo** | 90 | 200 | 5 | 10% | 200% | 100% | 10% | 2x DMG, 1 weapon only |

## Weapons (10 Types)

| Weapon | Damage | Fire Rate | Special |
|--------|--------|-----------|---------|
| Pistol | 15 | 2.0/s | Balanced |
| Shotgun | 8×5 | 0.8/s | 5 pellet spread |
| SMG | 6 | 8.0/s | High fire rate |
| Rifle | 10 | 4.0/s | 2 pierce |
| Sniper | 50 | 0.5/s | 5 pierce |
| Rocket Launcher | 30 | 0.6/s | Explosive |
| Homing Missile | 12×2 | 1.5/s | Auto-tracking |
| Grenade Launcher | 25 | 1.0/s | Arcing shots |
| Laser | 20 | 3.0/s | Instant hit |
| Burst Rifle | 12 | 2.5/s | 3-round burst |

## Project Structure

```
tomato-bro/
├── scenes/          # Godot scene files (.tscn)
│   ├── main/        # Main game scene
│   ├── player/      # Player character
│   ├── enemies/     # Enemy types
│   ├── weapons/     # Weapon systems
│   └── ui/          # UI scenes (menu, HUD)
├── scripts/         # GDScript files
│   ├── autoload/    # Global singletons (GameManager)
│   ├── entities/    # Player, Enemy, Pickup
│   ├── weapons/     # Weapon and projectile logic
│   ├── ui/          # UI controllers
│   └── resources/   # Character/Weapon data
├── resources/       # Game data resources
│   ├── characters/  # 8 character definitions
│   └── weapons/     # 10 weapon definitions
├── assets/          # Game assets
│   ├── sprites/     # Pixel art sprites
│   └── audio/       # Sound effects and music
└── README.md
```

## Requirements

- **Godot Engine**: 4.3 or later (Mono version recommended)
- **Platform**: Windows, macOS, Linux

## How to Run

1. Install Godot Engine 4.3+ from https://godotengine.org/
2. Open Godot and import this project
3. Press F5 to run the game

## GitHub

Repository: https://github.com/ruixu2/tomato-bro (Private)

## License

All rights reserved. This is a fan project inspired by Brotato.

## Credits

- Original Inspiration: Brotato by Blobfish
- Engine: Godot Engine (MIT License)
