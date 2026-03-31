extends Control
## Level Up Screen - displays upgrade choices when player levels up

@onready var title_label: Label = $TitleLabel
@onready var choices_container: VBoxContainer = $ChoicesContainer
@onready var close_button: Button = $CloseButton

var available_choices: Array[Dictionary] = []


func _ready() -> void:
	hide()
	GameManager.player.level_up_requested.connect(_on_level_up_requested)
	close_button.pressed.connect(_on_close_button_pressed)


func _on_level_up_requested() -> void:
	show()
	generate_choices()
	display_choices()


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
	if GameManager.player and GameManager.player.has_method("add_stat"):
		GameManager.player.add_stat(choice.stat, choice.value)
	
	# Level up complete
	GameManager.game_state = GameManager.GameState.PLAYING
	hide()


func _on_close_button_pressed() -> void:
	GameManager.game_state = GameManager.GameState.PLAYING
	hide()
