class_name RocketLauncherWeaponData
extends WeaponData
## Rocket Launcher - Explosive area damage

func _init():
	weapon_name = "Rocket Launcher"
	weapon_id = "rocket_launcher"
	description = "Fires explosive rockets. Deals area damage on impact."
	rarity = 3
	
	base_damage = 30.0
	fire_rate = 0.6
	projectile_speed = 250.0
	projectile_lifetime = 3.0
	pierce = 0
	projectile_count = 1
	
	spread_angle = 0.0
	burst_count = 1
	has_homing = false
	homing_strength = 0.0
	
	projectile_color = Color(1.0, 0.3, 0.1)
	projectile_size = Vector2(12, 12)
	
	damage_per_level = 6.0
	fire_rate_per_level = 0.03
