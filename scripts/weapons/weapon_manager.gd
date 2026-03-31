extends Node
class_name WeaponManager
## Weapon Manager - Handles weapon inventory, switching, and equipping

signal weapon_added(weapon: Weapon)
signal weapon_removed(weapon: Weapon)
signal weapon_equipped(weapon: Weapon, slot: int)
signal weapon_swapped(old_weapon: Weapon, new_weapon: Weapon)

const MAX_WEAPONS = 6

var weapons: Array[Weapon] = []
var equipped_slots: Array[int] = []
var player: Node2D = null


func _ready() -> void:
	weapons.resize(MAX_WEAPONS)
	weapons.fill(null)


func setup(p_player: Node2D) -> void:
	player = p_player


func add_weapon(weapon_data: WeaponData, slot: int = -1) -> bool:
	# Find empty slot if not specified
	if slot == -1:
		slot = _find_empty_slot()
	
	if slot == -1 or slot >= MAX_WEAPONS:
		return false  # No empty slot available
	
	# Remove existing weapon in slot if any
	if weapons[slot] != null:
		remove_weapon(slot)
	
	# Create new weapon
	var weapon = _create_weapon(weapon_data)
	weapons[slot] = weapon
	
	# Add to player as child
	if player:
		player.add_child(weapon)
		weapon.global_position = player.global_position
	
	weapon_added.emit(weapon)
	return true


func remove_weapon(slot: int) -> bool:
	if slot < 0 or slot >= MAX_WEAPONS:
		return false
	
	var weapon = weapons[slot]
	if weapon:
		weapon.queue_free()
		weapons[slot] = null
		weapon_removed.emit(weapon)
		return true
	
	return false


func equip_weapon(slot: int) -> bool:
	if slot < 0 or slot >= MAX_WEAPONS:
		return false
	
	var weapon = weapons[slot]
	if not weapon:
		return false
	
	# Deactivate all weapons first
	for w in weapons:
		if w:
			w.is_active = false
	
	# Activate selected weapon
	weapon.is_active = true
	weapon_equipped.emit(weapon, slot)
	return true


func swap_weapons(slot_a: int, slot_b: int) -> bool:
	if slot_a < 0 or slot_a >= MAX_WEAPONS or slot_b < 0 or slot_b >= MAX_WEAPONS:
		return false
	
	var weapon_a = weapons[slot_a]
	var weapon_b = weapons[slot_b]
	
	weapons[slot_a] = weapon_b
	weapons[slot_b] = weapon_a
	
	weapon_swapped.emit(weapon_a, weapon_b)
	return true


func upgrade_weapon(slot: int) -> bool:
	if slot < 0 or slot >= MAX_WEAPONS:
		return false
	
	var weapon = weapons[slot]
	if weapon:
		weapon.upgrade()
		return true
	
	return false


func get_weapon(slot: int) -> Weapon:
	if slot < 0 or slot >= MAX_WEAPONS:
		return null
	return weapons[slot]


func get_all_weapons() -> Array[Weapon]:
	var result: Array[Weapon] = []
	for weapon in weapons:
		if weapon:
			result.append(weapon)
	return result


func get_weapon_count() -> int:
	var count = 0
	for weapon in weapons:
		if weapon:
			count += 1
	return count


func has_empty_slot() -> bool:
	return _find_empty_slot() != -1


func _find_empty_slot() -> int:
	for i in range(MAX_WEAPONS):
		if weapons[i] == null:
			return i
	return -1


func _create_weapon(weapon_data: WeaponData) -> Weapon:
	var weapon = Weapon.new()
	weapon.weapon_data = weapon_data
	
	# Load projectile scene
	var projectile_path = "res://scenes/weapons/projectile.tscn"
	if ResourceLoader.exists(projectile_path):
		weapon.projectile_scene = load(projectile_path)
	
	weapon.is_active = false  # Start inactive, will be equipped later
	
	return weapon


func get_total_dps() -> float:
	var total_dps = 0.0
	for weapon in weapons:
		if weapon and weapon.weapon_data:
			var damage = weapon.weapon_data.get_damage_at_level(weapon.level)
			var fire_rate = weapon.weapon_data.get_fire_rate_at_level(weapon.level)
			total_dps += damage * fire_rate
	return total_dps


func get_stats_summary() -> Array[Dictionary]:
	var stats: Array[Dictionary] = []
	for i in range(MAX_WEAPONS):
		var weapon = weapons[i]
		if weapon:
			stats.append({
				"slot": i,
				"name": weapon.weapon_data.weapon_name,
				"level": weapon.level,
				"damage": weapon.weapon_data.get_damage_at_level(weapon.level),
				"fire_rate": weapon.weapon_data.get_fire_rate_at_level(weapon.level),
				"is_active": weapon.is_active
			})
		else:
			stats.append({"slot": i, "name": "Empty", "level": 0})
	return stats
