extends Node
## Game Manager - Global singleton for game state management
## Handles game state, wave management, spawning, and game flow

signal wave_started(wave_number: int)
signal wave_ended(wave_number: int)
signal game_over
signal victory
signal character_selected(character_data: CharacterData)

const MAX_WAVES: int = 20
const WAVE_DURATION: float = 60.0  # 60 seconds per wave (base duration)
const MIN_WAVE_DURATION: float = 30.0  # Minimum wave duration with speedup
const WAVE_SPEEDUP_MULTIPLIER: float = 2.0  # 2x speed = 30 seconds per wave

var current_wave: int = 0
var wave_timer: float = 0.0
var wave_time_elapsed: float = 0.0  # Track elapsed time for speedup calculation
var is_wave_active: bool = false
var enemies_remaining: int = 0
var game_state: GameState = GameState.MENU

var selected_character: CharacterData = null
var wave_speedup_enabled: bool = false  # Toggle for 2x wave speed

enum GameState {
	MENU,
	CHARACTER_SELECT,
	PLAYING,
	SHOP,
	LEVEL_UP,
	GAME_OVER,
	VICTORY
}

var player: Node2D = null
var score: int = 0
var gold: int = 0
var current_level: int = 1


func _ready() -> void:
	pass


func start_game(character_data: CharacterData = null) -> void:
	if character_data:
		selected_character = character_data
	else:
		# Default to tomato if no character selected
		selected_character = CharacterLoader.get_character("tomato")
	
	game_state = GameState.PLAYING
	current_wave = 0
	score = 0
	gold = 0
	current_level = 1
	character_selected.emit(selected_character)
	start_wave()


func start_wave() -> void:
	current_wave += 1
	if current_wave > MAX_WAVES:
		victory.emit()
		game_state = GameState.VICTORY
		return
	
	is_wave_active = true
	wave_timer = WAVE_DURATION
	wave_time_elapsed = 0.0  # Reset elapsed time
	wave_started.emit(current_wave)
	spawn_enemies()


func toggle_wave_speedup() -> void:
	wave_speedup_enabled = not wave_speedup_enabled


func spawn_enemies() -> void:
	# Spawn logic will be implemented in Game scene
	# Base enemy count scales with wave number
	enemies_remaining = 10 + current_wave * 5
	pass


func _process(delta: float) -> void:
	if game_state != GameState.PLAYING:
		return
	
	if is_wave_active:
		# Track elapsed time
		wave_time_elapsed += delta
		
		# Calculate effective delta based on speedup
		var effective_delta = delta
		if wave_speedup_enabled:
			effective_delta = delta * WAVE_SPEEDUP_MULTIPLIER
		
		wave_timer -= effective_delta
		
		# Ensure wave ends at minimum duration (30 seconds)
		if wave_speedup_enabled and wave_time_elapsed >= MIN_WAVE_DURATION:
			wave_timer = 0
		
		if wave_timer <= 0:
			end_wave()


func end_wave() -> void:
	is_wave_active = false
	wave_time_elapsed = 0.0
	wave_ended.emit(current_wave)
	
	if enemies_remaining <= 0:
		# Go to shop or level up
		game_state = GameState.LEVEL_UP
	else:
		# Start next wave after delay
		await get_tree().create_timer(2.0).timeout
		start_wave()


func on_enemy_defeated() -> void:
	enemies_remaining -= 1
	if enemies_remaining <= 0 and is_wave_active:
		end_wave()


func add_gold(amount: int) -> void:
	gold += amount


func add_score(amount: int) -> void:
	score += amount


func return_to_menu() -> void:
	game_state = GameState.MENU
	selected_character = null
	player = null
	wave_speedup_enabled = false  # Reset speedup on return
