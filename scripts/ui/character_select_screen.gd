extends Control
class_name CharacterSelectScreen
## Character Selection Screen - allows player to choose their character before starting

signal character_selected(character_data: CharacterData)
signal start_game_pressed

@onready var title_label: Label = $TitleLabel
@onready var characters_container: VBoxContainer = $CharactersContainer
@onready var preview_panel: Panel = $PreviewPanel
@onready var preview_name: Label = $PreviewPanel/NameLabel
@onready var preview_description: Label = $PreviewPanel/DescriptionLabel
@onready var preview_stats: Label = $PreviewPanel/StatsLabel
@onready var preview_color: ColorRect = $PreviewPanel/ColorPreview
@onready var start_button: Button = $StartButton

var available_characters: Array[CharacterData] = []
var selected_character: CharacterData = null


func _ready() -> void:
	hide()
	_load_characters()
	_display_characters()
	
	start_button.pressed.connect(_on_start_button_pressed)
	start_button.disabled = true


func show_screen() -> void:
	show()
	# Select first character by default
	if available_characters.size() > 0:
		_select_character(available_characters[0])


func _load_characters() -> void:
	available_characters = CharacterLoader.get_all_characters()


func _display_characters() -> void:
	# Clear existing buttons
	for child in characters_container.get_children():
		child.queue_free()
	
	# Create character buttons
	for character in available_characters:
		var button = Button.new()
		button.custom_minimum_size = Vector2(200, 50)
		button.text = character.character_name
		button.pressed.connect(_on_character_button_pressed.bind(character))
		characters_container.add_child(button)


func _select_character(character: CharacterData) -> void:
	selected_character = character
	
	# Update preview
	preview_name.text = character.character_name
	preview_description.text = character.description
	preview_stats.text = character.get_stat_string()
	preview_color.color = character.character_color
	
	# Update button states
	for button in characters_container.get_children():
		if button.text == character.character_name:
			button.button_pressed = true
	
	start_button.disabled = false


func _on_character_button_pressed(character: CharacterData) -> void:
	_select_character(character)
	character_selected.emit(character)


func _on_start_button_pressed() -> void:
	if selected_character:
		start_game_pressed.emit()


func get_selected_character() -> CharacterData:
	return selected_character
