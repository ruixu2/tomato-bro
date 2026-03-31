class_name RocketeerCharacterData
extends CharacterData
## Rocketeer (火箭手) - Starts with rocket launcher, explosive expertise

func _init():
	character_name = "Rocketeer"
	character_id = "rocketeer"
	description = "An explosive tomato expert. Starts with a rocket launcher."
	unlock_requirement = "Default"
	
	max_health = 90
	move_speed = 195.0
	armor = 5.0
	luck = 5.0
	pickup_range = 100.0
	
	attack_speed_mult = 1.0
	damage_mult = 1.2
	crit_chance = 5.0
	crit_mult = 2.2
	hp_regen = 0.0
	
	special_ability = "+20% Damage, +5 Armor, Starts with Rocket Launcher"
	starting_weapon_id = "rocket_launcher"
	starting_weapons = 1
	
	character_color = Color(1, 0.5, 0.1)
