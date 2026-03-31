class_name BurstRifleWeaponData
extends WeaponData
## Burst Rifle - Fires 3-round bursts

func _init():
	weapon_name = "Burst Rifle"
	weapon_id = "burst_rifle"
	description = "Fires 3-round bursts. Good accuracy and damage."
	rarity = 2
	
	base_damage = 12.0
	fire_rate = 2.5
	projectile_speed = 550.0
	projectile_lifetime = 3.0
	pierce = 1
	projectile_count = 1
	
	spread_angle = 3.0
	burst_count = 3
	burst_delay = 0.12
	
	projectile_color = Color(0.9, 0.9, 0.2)
	projectile_size = Vector2(7, 7)
	
	damage_per_level = 2.5
	fire_rate_per_level = 0.1
