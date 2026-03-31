extends Control
class_name MainMenu
## Main Menu - handles menu navigation and character selection

@onready var title_label: Label = $TitleLabel
@onready var menu_container: VBoxContainer = $MenuContainer
@onready var start_button: Button = $MenuContainer/StartButton
@onready var character_select: Control = $CharacterSelectScreen

var selected_character: CharacterData = null


func _ready() -> void:
	GameManager.game_state = GameManager.GameState.MENU
	GameManager.return_to_menu.connect(_on_return_to_menu)
	
	start_button.pressed.connect(_on_start_button_pressed)
	character_select.character_selected.connect(_on_character_selected)
	character_select.start_game_pressed.connect(_on_character_confirm)


func _on_start_button_pressed() -> void:
	# Show character selection
	menu_container.hide()
	character_select.show_screen()


func _on_character_selected(character: CharacterData) -> void:
	selected_character = character


func _on_character_confirm() -> void:
	if selected_character:
		character_select.hide()
		GameManager.start_game(selected_character)


func _on_return_to_menu() -> void:
	character_select.hide()
	menu_container.show()
	GameManager.game_state = GameManager.GameState.MENU
