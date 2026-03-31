class_name GrenadeLauncherWeaponData
extends WeaponData
## Grenade Launcher - Arcing projectiles with explosion

func _init():
	weapon_name = "Grenade Launcher"
	weapon_id = "grenade_launcher"
	description = "Fires grenades that explode on impact."
	rarity = 2
	
	base_damage = 25.0
	fire_rate = 1.0
	projectile_speed = 200.0
	projectile_lifetime = 2.5
	pierce = 0
	projectile_count = 1
	
	spread_angle = 0.0
	burst_count = 1
	
	projectile_color = Color(0.2, 0.8, 0.2)
	projectile_size = Vector2(14, 14)
	
	damage_per_level = 5.0
	fire_rate_per_level = 0.05
