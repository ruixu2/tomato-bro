class_name RifleWeaponData
extends WeaponData
## Rifle - Medium range, consistent damage

func _init():
	weapon_name = "Rifle"
	weapon_id = "rifle"
	description = "Reliable automatic weapon. Good all-around performance."
	rarity = 1
	
	base_damage = 10.0
	fire_rate = 4.0
	projectile_speed = 500.0
	projectile_lifetime = 3.0
	pierce = 2
	projectile_count = 1
	
	spread_angle = 5.0
	burst_count = 1
	
	projectile_color = Color(1.0, 0.6, 0.2)
	projectile_size = Vector2(7, 7)
	
	damage_per_level = 2.0
	fire_rate_per_level = 0.15
