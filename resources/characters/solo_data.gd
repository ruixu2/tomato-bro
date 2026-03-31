class_name SoloCharacterData
extends CharacterData
## Solo (独行者) - Can only equip 1 weapon, but damage stats are doubled

func _init():
	character_name = "Solo"
	character_id = "solo"
	description = "A lone tomato warrior. Can only wield one weapon, but deals double damage."
	unlock_requirement = "Default"
	
	max_health = 90
	move_speed = 200.0
	armor = 5.0
	luck = 10.0
	pickup_range = 100.0
	
	attack_speed_mult = 1.0
	damage_mult = 2.0  # Double damage!
	crit_chance = 10.0
	crit_mult = 2.5
	hp_regen = 0.0
	
	special_ability = "2x Damage, +10% Crit, -1 Weapon Slot (max 1 weapon)"
	starting_weapon_id = "rifle"
	starting_weapons = 1
	
	character_color = Color(0.9, 0.1, 0.5)
