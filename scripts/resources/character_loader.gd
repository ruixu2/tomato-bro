class_name CharacterLoader
extends RefCounted
## Utility class for loading and managing character data resources

static var _character_cache: Dictionary = {}
static var _character_paths: Dictionary = {
	"tomato": "res://resources/characters/tomato_data.gd",
	"warrior": "res://resources/characters/warrior_data.gd",
	"ranger": "res://resources/characters/ranger_data.gd",
	"mage": "res://resources/characters/mage_data.gd",
	"tank": "res://resources/characters/tank_data.gd",
	"assassin": "res://resources/characters/assassin_data.gd",
	"rocketeer": "res://resources/characters/rocketeer_data.gd",
	"sniper": "res://resources/characters/sniper_character_data.gd",
}


static func get_character(character_id: String) -> CharacterData:
	if character_id in _character_cache:
		return _character_cache[character_id]
	
	if character_id not in _character_paths:
		push_warning("Character not found: ", character_id)
		return null
	
	var script = load(_character_paths[character_id])
	if script:
		var character_data = script.new()
		_character_cache[character_id] = character_data
		return character_data
	
	return null


static func get_all_characters() -> Array[CharacterData]:
	var characters: Array[CharacterData] = []
	for character_id in _character_paths:
		var character = get_character(character_id)
		if character:
			characters.append(character)
	return characters


static func get_unlocked_characters() -> Array[CharacterData]:
	# For now, all characters are unlocked
	# Can be extended with unlock requirements
	return get_all_characters()


static func get_random_character(exclude_ids: Array[String] = []) -> CharacterData:
	var available: Array[CharacterData] = []
	for character_id in _character_paths:
		if character_id not in exclude_ids:
			var character = get_character(character_id)
			if character:
				available.append(character)
	
	if available.is_empty():
		return null
	
	available.shuffle()
	return available[0]


static func clear_cache() -> void:
	_character_cache.clear()
