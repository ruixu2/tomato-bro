class_name TankCharacterData
extends CharacterData
## Tank (坦克) - Extremely high health and armor, very slow

func _init():
	character_name = "Tank"
	character_id = "tank"
	description = "An armored tomato fortress. Absorbs damage but moves slowly."
	unlock_requirement = "Default"
	
	max_health = 200
	move_speed = 150.0
	armor = 20.0
	luck = 0.0
	pickup_range = 80.0
	
	attack_speed_mult = 0.8
	damage_mult = 0.9
	crit_chance = 0.0
	crit_mult = 2.0
	hp_regen = 0.5
	
	special_ability = "+100 HP, +20 Armor, +0.5 HP/s regen, -50 Move Speed"
	starting_weapon_id = "shotgun"
	starting_weapons = 1
	
	character_color = Color(0.4, 0.4, 0.4)
