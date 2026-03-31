extends CharacterBody2D
class_name Player
## Player entity - controls movement, stats, weapons, and leveling

signal level_up_requested
signal health_changed(new_health: int, max_health: int)
signal xp_changed(current_xp: int, max_xp: int)
signal weapon_manager_ready(manager: WeaponManager)

@export_group("Stats")
@export var max_health: int = 100
@export var health: int = 100
@export var move_speed: float = 200.0
@export var armor: float = 0.0
@export var luck: float = 0.0
@export var pickup_range: float = 100.0

@export_group("Combat")
@export var attack_speed_mult: float = 1.0
@export var damage_mult: float = 1.0
@export var crit_chance: float = 0.0
@export var crit_mult: float = 2.0
@export var hp_regen: float = 0.0

var current_xp: int = 0
var xp_to_next_level: int = 10
var level: int = 1

var weapon_manager: WeaponManager = null
var is_alive: bool = true
var character_data: CharacterData = null


func _ready() -> void:
	# Setup weapon manager
	weapon_manager = WeaponManager.new()
	weapon_manager.name = "WeaponManager"
	add_child(weapon_manager)
	weapon_manager.setup(self)
	
	# Add to players group
	add_to_group("players")
	
	# Connect to character select
	GameManager.character_selected.connect(_on_character_selected)
	
	weapon_manager_ready.emit(weapon_manager)
	update_health_display()


func _on_character_selected(character: CharacterData) -> void:
	if character:
		character_data = character
		_apply_character_stats(character)


func _apply_character_stats(character: CharacterData) -> void:
	max_health = character.max_health
	health = character.max_health
	move_speed = character.move_speed
	armor = character.armor
	luck = character.luck
	pickup_range = character.pickup_range
	attack_speed_mult = character.attack_speed_mult
	damage_mult = character.damage_mult
	crit_chance = character.crit_chance
	crit_mult = character.crit_mult
	hp_regen = character.hp_regen
	
	# Add starting weapon
	if character.starting_weapon_id:
		var weapon_data = WeaponLoader.get_weapon(character.starting_weapon_id)
		if weapon_data:
			add_weapon(weapon_data, 0)
	
	update_health_display()


func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	# HP regeneration
	if hp_regen > 0:
		health = min(health + hp_regen * delta, max_health)
	
	# Get input movement
	var input_dir = Vector2.ZERO
	input_dir.y = Input.get_axis("move_up", "move_down")
	input_dir.x = Input.get_axis("move_left", "move_right")
	
	# Also support arrow keys
	if input_dir == Vector2.ZERO:
		input_dir.y = Input.get_axis("move_up_alt", "move_down_alt")
		input_dir.x = Input.get_axis("move_left_alt", "move_right_alt")
	
	velocity = input_dir.normalized() * move_speed
	move_and_slide()


func take_damage(amount: float) -> void:
	if not is_alive:
		return
	
	# Apply armor reduction
	var actual_damage = amount * (100.0 / (100.0 + armor))
	health -= int(actual_damage)
	update_health_display()
	
	if health <= 0:
		die()


func heal(amount: int) -> void:
	health = min(health + amount, max_health)
	update_health_display()


func die() -> void:
	is_alive = false
	GameManager.game_over.emit()
	queue_free()


func add_xp(amount: int) -> void:
	if not is_alive:
		return
	
	current_xp += amount
	update_xp_display()
	
	if current_xp >= xp_to_next_level:
		level_up()


func level_up() -> void:
	current_xp -= xp_to_next_level
	level += 1
	xp_to_next_level = int(xp_to_next_level * 1.5)
	level_up_requested.emit()
	GameManager.game_state = GameManager.GameState.LEVEL_UP
	update_xp_display()


func update_health_display() -> void:
	health_changed.emit(health, max_health)


func update_xp_display() -> void:
	xp_changed.emit(current_xp, xp_to_next_level)


func add_stat(stat_name: String, value: float) -> void:
	match stat_name:
		"max_health":
			max_health += int(value)
			health += int(value)
		"move_speed":
			move_speed += value
		"armor":
			armor += value
		"luck":
			luck += value
		"attack_speed":
			attack_speed_mult += value
		"damage":
			damage_mult += value
		"crit_chance":
			crit_chance += value
		"crit_mult":
			crit_mult += value
		"hp_regen":
			hp_regen += value
	
	update_health_display()


func add_weapon(weapon_data: WeaponData, slot: int = -1) -> bool:
	if weapon_manager:
		return weapon_manager.add_weapon(weapon_data, slot)
	return false


func get_weapon_manager() -> WeaponManager:
	return weapon_manager


func get_total_dps() -> float:
	if weapon_manager:
		return weapon_manager.get_total_dps()
	return 0.0
