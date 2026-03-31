class_name WeaponData
extends Resource
## Weapon data resource - defines weapon properties and stats

@export_group("Basic Info")
@export var weapon_name: String = "Unnamed Weapon"
@export var weapon_id: String = "weapon_base"
@export var description: String = ""
@export var rarity: int = 1  # 1=Common, 2=Rare, 3=Epic, 4=Legendary

@export_group("Combat Stats")
@export var base_damage: float = 10.0
@export var fire_rate: float = 1.0  # shots per second
@export var projectile_speed: float = 300.0
@export var projectile_lifetime: float = 3.0
@export var pierce: int = 0
@export var projectile_count: int = 1  # for shotgun/multishot

@export_group("Special Properties")
@export var has_homing: bool = false
@export var homing_strength: float = 0.0
@export var spread_angle: float = 0.0  # degrees
@export var burst_count: int = 1  # projectiles per burst
@export var burst_delay: float = 0.1  # delay between burst shots

@export_group("Visuals")
@export var projectile_color: Color = Color.YELLOW
@export var projectile_size: Vector2 = Vector2(8, 8)
@export var muzzle_flash_color: Color = Color.ORANGE

@export_group("Scaling")
@export var damage_per_level: float = 2.0
@export var fire_rate_per_level: float = 0.1


func get_damage_at_level(level: int) -> float:
	return base_damage + (damage_per_level * level)


func get_fire_rate_at_level(level: int) -> float:
	return fire_rate + (fire_rate_per_level * level)
