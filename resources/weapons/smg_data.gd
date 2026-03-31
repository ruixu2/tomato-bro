class_name SMGWeaponData
extends WeaponData
## SMG - High fire rate, lower damage per shot

func _init():
	weapon_name = "SMG"
	weapon_id = "smg"
	description = "High rate of fire. Great for clearing weak enemies."
	rarity = 1
	
	base_damage = 6.0
	fire_rate = 8.0
	projectile_speed = 450.0
	projectile_lifetime = 2.5
	pierce = 1
	projectile_count = 1
	
	spread_angle = 10.0
	burst_count = 1
	
	projectile_color = Color(0.8, 0.8, 1.0)
	projectile_size = Vector2(6, 6)
	
	damage_per_level = 1.0
	fire_rate_per_level = 0.3
