class_name SniperCharacterData
extends CharacterData
## Sniper (狙击手) - High crit and pierce, starts with sniper rifle

func _init():
	character_name = "Sniper"
	character_id = "sniper"
	description = "A precise tomato marksman. High crit and pierce."
	unlock_requirement = "Default"
	
	max_health = 70
	move_speed = 200.0
	armor = 0.0
	luck = 15.0
	pickup_range = 150.0
	
	attack_speed_mult = 0.85
	damage_mult = 1.1
	crit_chance = 20.0
	crit_mult = 2.5
	hp_regen = 0.0
	
	special_ability = "+20% Crit Chance, +15% Luck, +50 Pickup Range, Starts with Sniper"
	starting_weapon_id = "sniper"
	starting_weapons = 1
	
	character_color = Color(0.2, 0.6, 0.2)
