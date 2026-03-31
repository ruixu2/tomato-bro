class_name MageCharacterData
extends CharacterData
## Mage (法师) - High damage and crit, very low health

func _init():
	character_name = "Mage"
	character_id = "mage"
	description = "A glass cannon tomato. Deals massive damage but very fragile."
	unlock_requirement = "Default"
	
	max_health = 60
	move_speed = 190.0
	armor = 0.0
	luck = 5.0
	pickup_range = 110.0
	
	attack_speed_mult = 1.0
	damage_mult = 1.4
	crit_chance = 10.0
	crit_mult = 2.5
	hp_regen = 0.0
	
	special_ability = "+40% Damage, +10% Crit Chance, -40 HP"
	starting_weapon_id = "laser"
	starting_weapons = 1
	
	character_color = Color(0.6, 0.2, 0.8)
