class_name HomingMissileWeaponData
extends WeaponData
## Homing Missile - Automatically tracks and follows enemies

func _init():
	weapon_name = "Homing Missile"
	weapon_id = "homing_missile"
	description = "Missiles that automatically track nearby enemies."
	rarity = 2
	
	base_damage = 12.0
	fire_rate = 1.5
	projectile_speed = 200.0
	projectile_lifetime = 5.0
	pierce = 0
	projectile_count = 2
	
	spread_angle = 15.0
	burst_count = 1
	has_homing = true
	homing_strength = 3.0
	
	projectile_color = Color(0.5, 1.0, 0.5)
	projectile_size = Vector2(8, 8)
	
	damage_per_level = 2.5
	fire_rate_per_level = 0.1
