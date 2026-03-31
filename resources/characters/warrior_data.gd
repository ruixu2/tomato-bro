class_name WarriorCharacterData
extends CharacterData
## Warrior (战士) - High health and armor, slower movement

func _init():
	character_name = "Warrior"
	character_id = "warrior"
	description = "A tough tomato with high defense. Trades speed for survivability."
	unlock_requirement = "Default"
	
	max_health = 140
	move_speed = 180.0
	armor = 10.0
	luck = 0.0
	pickup_range = 100.0
	
	attack_speed_mult = 0.9
	damage_mult = 1.1
	crit_chance = 0.0
	crit_mult = 2.0
	hp_regen = 0.0
	
	special_ability = "+40 HP, +10 Armor, -10% Move Speed"
	starting_weapon_id = "rifle"
	starting_weapons = 1
	
	character_color = Color(0.8, 0.2, 0.2)
