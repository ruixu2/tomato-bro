class_name ShotgunWeaponData
extends WeaponData
## Shotgun - Fires multiple projectiles in a spread pattern

func _init():
	weapon_name = "Shotgun"
	weapon_id = "shotgun"
	description = "Fires multiple pellets in a spread. Devastating at close range."
	rarity = 2
	
	base_damage = 8.0
	fire_rate = 0.8
	projectile_speed = 350.0
	projectile_lifetime = 2.0
	pierce = 0
	projectile_count = 5
	
	spread_angle = 45.0
	burst_count = 1
	
	projectile_color = Color(1.0, 0.8, 0.2)
	projectile_size = Vector2(6, 6)
	
	damage_per_level = 1.5
	fire_rate_per_level = 0.05
