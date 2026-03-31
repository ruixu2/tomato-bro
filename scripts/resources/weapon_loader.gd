class_name WeaponLoader
extends RefCounted
## Utility class for loading and managing weapon data resources

static var _weapon_cache: Dictionary = {}
static var _weapon_paths: Dictionary = {
	"pistol": "res://resources/weapons/pistol_data.gd",
	"shotgun": "res://resources/weapons/shotgun_data.gd",
	"smg": "res://resources/weapons/smg_data.gd",
	"rifle": "res://resources/weapons/rifle_data.gd",
	"sniper": "res://resources/weapons/sniper_data.gd",
	"rocket_launcher": "res://resources/weapons/rocket_launcher_data.gd",
	"homing_missile": "res://resources/weapons/homing_missile_data.gd",
	"grenade_launcher": "res://resources/weapons/grenade_launcher_data.gd",
	"laser": "res://resources/weapons/laser_data.gd",
	"burst_rifle": "res://resources/weapons/burst_rifle_data.gd",
}


static func get_weapon(weapon_id: String) -> WeaponData:
	if weapon_id in _weapon_cache:
		return _weapon_cache[weapon_id]
	
	if weapon_id not in _weapon_paths:
		push_warning("Weapon not found: ", weapon_id)
		return null
	
	var script = load(_weapon_paths[weapon_id])
	if script:
		var weapon_data = script.new()
		_weapon_cache[weapon_id] = weapon_data
		return weapon_data
	
	return null


static func get_all_weapons() -> Array[WeaponData]:
	var weapons: Array[WeaponData] = []
	for weapon_id in _weapon_paths:
		var weapon = get_weapon(weapon_id)
		if weapon:
			weapons.append(weapon)
	return weapons


static func get_weapons_by_rarity(rarity: int) -> Array[WeaponData]:
	var weapons: Array[WeaponData] = []
	for weapon_id in _weapon_paths:
		var weapon = get_weapon(weapon_id)
		if weapon and weapon.rarity == rarity:
			weapons.append(weapon)
	return weapons


static func get_random_weapon(exclude_ids: Array[String] = []) -> WeaponData:
	var available: Array[WeaponData] = []
	for weapon_id in _weapon_paths:
		if weapon_id not in exclude_ids:
			var weapon = get_weapon(weapon_id)
			if weapon:
				available.append(weapon)
	
	if available.is_empty():
		return null
	
	available.shuffle()
	return available[0]


static func get_random_weapon_by_rarity(rarity: int, exclude_ids: Array[String] = []) -> WeaponData:
	var available: Array[WeaponData] = []
	for weapon_id in _weapon_paths:
		if weapon_id not in exclude_ids:
			var weapon = get_weapon(weapon_id)
			if weapon and weapon.rarity == rarity:
				available.append(weapon)
	
	if available.is_empty():
		return null
	
	available.shuffle()
	return available[0]


static func clear_cache() -> void:
	_weapon_cache.clear()
