class_name AssassinCharacterData
extends CharacterData
## Assassin (刺客) - High crit chance and move speed, low health

func _init():
	character_name = "Assassin"
	character_id = "assassin"
	description = "A deadly tomato striker. High crit and mobility."
	unlock_requirement = "Default"
	
	max_health = 75
	move_speed = 240.0
	armor = 0.0
	luck = 10.0
	pickup_range = 100.0
	
	attack_speed_mult = 1.15
	damage_mult = 1.0
	crit_chance = 15.0
	crit_mult = 3.0
	hp_regen = 0.0
	
	special_ability = "+15% Crit Chance, +3x Crit Mult, +40 Move Speed, -25 HP"
	starting_weapon_id = "burst_rifle"
	starting_weapons = 1
	
	character_color = Color(0.2, 0.2, 0.2)
