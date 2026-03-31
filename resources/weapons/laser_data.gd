class_name LaserWeaponData
extends WeaponData
## Laser - Instant hit beam weapon

func _init():
	weapon_name = "Laser"
	weapon_id = "laser"
	description = "Instant hit beam. High accuracy and moderate pierce."
	rarity = 3
	
	base_damage = 20.0
	fire_rate = 3.0
	projectile_speed = 1500.0
	projectile_lifetime = 1.0
	pierce = 3
	projectile_count = 1
	
	spread_angle = 0.0
	burst_count = 1
	
	projectile_color = Color(1.0, 0.0, 1.0)
	projectile_size = Vector2(4, 12)
	
	damage_per_level = 4.0
	fire_rate_per_level = 0.2
