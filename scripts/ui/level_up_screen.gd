extends Control
## Level Up Screen - displays upgrade choices when player levels up

@onready var title_label: Label = $TitleLabel
@onready var choices_container: VBoxContainer = $ChoicesContainer
@onready var close_button: Button = $CloseButton
@onready var weapon_select: Control = $WeaponSelectScreen

var available_choices: Array[Dictionary] = []
var player: Node2D = null
var show_weapon_select: bool = false


func _ready() -> void:
	hide()
	
	# Connect to game manager for player reference
	await get_tree().create_timer(0.3).timeout
	if GameManager.player:
		player = GameManager.player
	
	close_button.pressed.connect(_on_close_button_pressed)


func _on_level_up_requested() -> void:
	show()
	show_weapon_select = _should_show_weapon_select()
	
	if show_weapon_select:
		title_label.text = "Level Up! Choose a Weapon or Upgrade"
		_display_weapon_options()
	else:
		title_label.text = "Choose an Upgrade!"
		generate_choices()
		display_choices()


func _should_show_weapon_select() -> bool:
	if not player or not player.weapon_manager:
		return true
	
	# Check character's max weapon slots
	var max_slots = player.weapon_manager.max_weapon_slots
	
	# Show weapon select if player has empty slot and less than max weapons
	return player.weapon_manager.has_empty_slot() and player.weapon_manager.get_weapon_count() < max_slots


func _display_weapon_options() -> void:
	# Clear existing choices
	for child in choices_container.get_children():
		child.queue_free()
	
	# Create weapon selection button
	var weapon_button = Button.new()
	weapon_button.text = "Select New Weapon"
	weapon_button.custom_minimum_size = Vector2(250, 60)
	weapon_button.pressed.connect(_on_weapon_select_pressed)
	choices_container.add_child(weapon_button)
	
	# Create upgrade button if player has weapons
	if player.weapon_manager.get_weapon_count() > 0:
		var upgrade_button = Button.new()
		upgrade_button.text = "Upgrade Existing Weapon"
		upgrade_button.custom_minimum_size = Vector2(250, 60)
		upgrade_button.pressed.connect(_on_upgrade_select_pressed)
		choices_container.add_child(upgrade_button)
	
	# Add stat upgrades
	var separator = HSeparator.new()
	choices_container.add_child(separator)
	
	generate_choices()
	for choice in available_choices:
		var button = Button.new()
		button.text = "%s\n%s" % [choice.name, choice.description]
		button.custom_minimum_size = Vector2(200, 60)
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_container.add_child(button)


func _on_weapon_select_pressed() -> void:
	if weapon_select:
		weapon_select.show_weapon_select(player)


func _on_upgrade_select_pressed() -> void:
	if weapon_select:
		weapon_select.show_upgrade_select(player)


func generate_choices() -> void:
	# Generate random upgrade choices
	available_choices.clear()
	
	var possible_upgrades = [
		{"name": "Max Health", "stat": "max_health", "value": 20, "description": "+20 Max HP"},
		{"name": "Move Speed", "stat": "move_speed", "value": 15, "description": "+15 Move Speed"},
		{"name": "Armor", "stat": "armor", "value": 5, "description": "+5 Armor"},
		{"name": "Luck", "stat": "luck", "value": 10, "description": "+10% Luck"},
		{"name": "Attack Speed", "stat": "attack_speed", "value": 0.15, "description": "+15% Attack Speed"},
		{"name": "Damage", "stat": "damage", "value": 0.15, "description": "+15% Damage"},
		{"name": "Crit Chance", "stat": "crit_chance", "value": 0.05, "description": "+5% Crit Chance"},
		{"name": "Crit Mult", "stat": "crit_mult", "value": 0.3, "description": "+30% Crit Multiplier"},
	]
	
	# Pick 3 random choices
	var shuffled = possible_upgrades.duplicate()
	shuffled.shuffle()
	available_choices = shuffled.slice(0, 3)


func display_choices() -> void:
	# Clear existing choices
	for child in choices_container.get_children():
		child.queue_free()
	
	# Create choice buttons
	for choice in available_choices:
		var button = Button.new()
		button.text = "%s\n%s" % [choice.name, choice.description]
		button.custom_minimum_size = Vector2(200, 60)
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_container.add_child(button)


func _on_choice_selected(choice: Dictionary) -> void:
	if player and player.has_method("add_stat"):
		player.add_stat(choice.stat, choice.value)
	
	# Level up complete
	_hide_and_continue()


func _hide_and_continue() -> void:
	GameManager.game_state = GameManager.GameState.PLAYING
	hide()


func _on_close_button_pressed() -> void:
	_hide_and_continue()
