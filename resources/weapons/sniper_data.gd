class_name SniperWeaponData
extends WeaponData
## Sniper - High damage, slow fire rate, high pierce

func _init():
	weapon_name = "Sniper Rifle"
	weapon_id = "sniper"
	description = "High damage and pierce. Fires slowly but punches through enemies."
	rarity = 3
	
	base_damage = 50.0
	fire_rate = 0.5
	projectile_speed = 800.0
	projectile_lifetime = 4.0
	pierce = 5
	projectile_count = 1
	
	spread_angle = 0.0
	burst_count = 1
	
	projectile_color = Color(0.0, 1.0, 0.5)
	projectile_size = Vector2(10, 10)
	
	damage_per_level = 10.0
	fire_rate_per_level = 0.02
