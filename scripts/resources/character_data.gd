class_name CharacterData
extends Resource
## Character data resource - defines character stats and properties

@export_group("Basic Info")
@export var character_name: String = "Unnamed Character"
@export var character_id: String = "character_base"
@export var description: String = ""
@export var unlock_requirement: String = "Default"

@export_group("Base Stats")
@export var max_health: int = 100
@export var move_speed: float = 200.0
@export var armor: float = 0.0
@export var luck: float = 0.0
@export var pickup_range: float = 100.0

@export_group("Combat Stats")
@export var attack_speed_mult: float = 1.0
@export var damage_mult: float = 1.0
@export var crit_chance: float = 0.0
@export var crit_mult: float = 2.0
@export var hp_regen: float = 0.0

@export_group("Special Abilities")
@export var special_ability: String = ""
@export var starting_weapon_id: String = ""
@export var starting_weapons: int = 1

@export_group("Visuals")
@export var character_color: Color = Color.RED
@export var character_sprite_path: String = ""


func get_stat_string() -> String:
	var stats = []
	stats.append("HP: %d" % max_health)
	stats.append("SPD: %.0f" % move_speed)
	stats.append("ARM: %.1f" % armor)
	stats.append("LUCK: %.0f%%" % (luck * 100))
	stats.append("DMG: %.0f%%" % (damage_mult * 100))
	stats.append("ATK SPD: %.0f%%" % (attack_speed_mult * 100))
	return ", ".join(stats)
