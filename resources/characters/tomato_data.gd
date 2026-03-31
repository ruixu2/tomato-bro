class_name TomatoCharacterData
extends CharacterData
## Tomato (番茄) - The balanced default character

func _init():
	character_name = "Tomato"
	character_id = "tomato"
	description = "A regular tomato brother. Well-balanced in all aspects."
	unlock_requirement = "Default"
	
	max_health = 100
	move_speed = 200.0
	armor = 0.0
	luck = 0.0
	pickup_range = 100.0
	
	attack_speed_mult = 1.0
	damage_mult = 1.0
	crit_chance = 0.0
	crit_mult = 2.0
	hp_regen = 0.0
	
	special_ability = "None - Balanced stats"
	starting_weapon_id = "pistol"
	starting_weapons = 1
	
	character_color = Color(1, 0.4, 0.2)
