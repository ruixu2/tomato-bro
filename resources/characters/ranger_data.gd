class_name RangerCharacterData
extends CharacterData
## Ranger (射手) - High attack speed and luck, lower health

func _init():
	character_name = "Ranger"
	character_id = "ranger"
	description = "A swift tomato with exceptional attack speed and luck."
	unlock_requirement = "Default"
	
	max_health = 80
	move_speed = 220.0
	armor = 0.0
	luck = 20.0
	pickup_range = 120.0
	
	attack_speed_mult = 1.3
	damage_mult = 0.9
	crit_chance = 5.0
	crit_mult = 2.0
	hp_regen = 0.0
	
	special_ability = "+30% Attack Speed, +20% Luck, +20 Move Speed, -20 HP"
	starting_weapon_id = "smg"
	starting_weapons = 1
	
	character_color = Color(0.2, 0.8, 0.2)
