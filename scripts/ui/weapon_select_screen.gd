extends Control
class_name WeaponSelectScreen
## Weapon Select Screen - allows player to choose new weapons or upgrade existing ones

signal weapon_selected(weapon_data: WeaponData)
signal upgrade_selected(slot: int)

@onready var title_label: Label = $TitleLabel
@onready var weapons_container: VBoxContainer = $WeaponsContainer
@onready var upgrade_container: VBoxContainer = $UpgradeContainer

var available_weapons: Array[WeaponData] = []
var player: Node2D = null


func _ready() -> void:
	hide()
	_load_available_weapons()


func show_weapon_select(p_player: Node2D) -> void:
	player = p_player
	show()
	title_label.text = "Choose a New Weapon"
	_display_weapon_choices()


func show_upgrade_select(p_player: Node2D) -> void:
	player = p_player
	show()
	title_label.text = "Upgrade a Weapon"
	_display_upgrade_choices()


func _load_available_weapons() -> void:
	available_weapons = WeaponLoader.get_all_weapons()


func _display_weapon_choices() -> void:
	# Clear existing choices
	_clear_container(weapons_container)
	
	# Filter weapons player doesn't have
	var player_weapons = _get_player_weapon_ids()
	var available_choices: Array[WeaponData] = []
	
	for weapon in available_weapons:
		if weapon.weapon_id not in player_weapons:
			available_choices.append(weapon)
	
	# If player has all weapons, allow duplicates
	if available_choices.is_empty():
		available_choices = available_weapons
	
	# Pick 3 random choices
	available_choices.shuffle()
	var choices = available_choices.slice(0, min(3, available_choices.size()))
	
	# Create weapon buttons
	for weapon in choices:
		var button = _create_weapon_button(weapon)
		weapons_container.add_child(button)


func _display_upgrade_choices() -> void:
	_clear_container(upgrade_container)
	
	if not player or not player.weapon_manager:
		title_label.text = "No weapons to upgrade"
		return
	
	title_label.text = "Upgrade a Weapon"
	
	# Show existing weapons for upgrade
	var weapons = player.weapon_manager.get_all_weapons()
	
	for weapon in weapons:
		var button = _create_upgrade_button(weapon)
		upgrade_container.add_child(button)


func _create_weapon_button(weapon_data: WeaponData) -> Button:
	var button = Button.new()
	button.custom_minimum_size = Vector2(280, 80)
	
	var stats = "Dmg: %.1f | Rate: %.1f/s | Pierce: %d" % [
		weapon_data.get_damage_at_level(1),
		weapon_data.get_fire_rate_at_level(1),
		weapon_data.pierce
	]
	button.text = "%s\n%s\n%s" % [
		weapon_data.weapon_name,
		weapon_data.description,
		stats
	]
	button.pressed.connect(_on_weapon_selected.bind(weapon_data))
	return button


func _create_upgrade_button(weapon: Weapon) -> Button:
	var button = Button.new()
	button.custom_minimum_size = Vector2(280, 70)
	
	var next_damage = weapon.weapon_data.get_damage_at_level(weapon.level + 1)
	var next_fire_rate = weapon.weapon_data.get_fire_rate_at_level(weapon.level + 1)
	
	button.text = "%s (Lv.%d → %d)\nDmg: %.1f → %.1f | Rate: %.1f → %.1f/s" % [
		weapon.weapon_data.weapon_name,
		weapon.level,
		weapon.level + 1,
		weapon.weapon_data.get_damage_at_level(weapon.level),
		next_damage,
		weapon.weapon_data.get_fire_rate_at_level(weapon.level),
		next_fire_rate
	]
	button.pressed.connect(_on_upgrade_selected.bind(weapon))
	return button


func _on_weapon_selected(weapon_data: WeaponData) -> void:
	if player and player.has_method("add_weapon"):
		player.add_weapon(weapon_data)
	_hide_and_continue()


func _on_upgrade_selected(weapon: Weapon) -> void:
	weapon.upgrade()
	_hide_and_continue()


func _hide_and_continue() -> void:
	hide()
	GameManager.game_state = GameManager.GameState.PLAYING


func _clear_container(container: VBoxContainer) -> void:
	for child in container.get_children():
		child.queue_free()


func _get_player_weapon_ids() -> Array[String]:
	var ids: Array[String] = []
	if player and player.weapon_manager:
		for weapon in player.weapon_manager.get_all_weapons():
			ids.append(weapon.weapon_data.weapon_id)
	return ids
