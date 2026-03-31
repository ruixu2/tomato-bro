class_name PistolWeaponData
extends WeaponData
## Pistol - Basic balanced weapon

func _init():
	weapon_name = "Pistol"
	weapon_id = "pistol"
	description = "A reliable sidearm. Balanced damage and fire rate."
	rarity = 1
	
	base_damage = 15.0
	fire_rate = 2.0
	projectile_speed = 400.0
	projectile_lifetime = 3.0
	pierce = 1
	projectile_count = 1
	
	spread_angle = 0.0
	burst_count = 1
	
	projectile_color = Color.YELLOW
	projectile_size = Vector2(8, 8)
	
	damage_per_level = 3.0
	fire_rate_per_level = 0.1
