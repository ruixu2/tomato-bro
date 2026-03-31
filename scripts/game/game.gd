extends Node2D
## Main game scene - handles game loop, spawning, and scene management

@export var player_scene: PackedScene
@export var enemy_scene: PackedScene
@export var pickup_scene: PackedScene

var player: Node2D = null
var enemy_container: Node2D = null
var pickup_container: Node2D = null
var projectile_container: Node2D = null

var spawn_timer: float = 0.0
var spawn_interval: float = 1.0


func _ready() -> void:
	# Set up containers
	enemy_container = $EnemyContainer
	pickup_container = $PickupContainer
	projectile_container = $ProjectileContainer
	
	# Spawn player
	spawn_player()
	
	# Connect to game manager
	GameManager.player = player
	
	# Connect signals
	GameManager.wave_started.connect(_on_wave_started)
	GameManager.wave_ended.connect(_on_wave_ended)


func spawn_player() -> void:
	if player_scene:
		player = player_scene.instantiate()
		player.position = Vector2.ZERO
		add_child(player)


func spawn_enemy(position: Vector2 = Vector2.ZERO) -> void:
	if not enemy_scene:
		return
	
	var enemy = enemy_scene.instantiate()
	if position == Vector2.ZERO:
		position = get_random_spawn_position()
	
	enemy.position = position
	enemy.add_to_group("enemies")
	
	if enemy_container:
		enemy_container.add_child(enemy)
	else:
		add_child(enemy)


func get_random_spawn_position() -> Vector2:
	# Spawn enemies at edge of screen, away from player
	var angle = randf() * TAU
	var distance = 300 + randf() * 100  # 300-400 pixels from center
	return Vector2(cos(angle), sin(angle)) * distance


func spawn_pickup(position: Vector2, xp_value: int = 1) -> void:
	if not pickup_scene:
		return
	
	var pickup = pickup_scene.instantiate()
	pickup.xp_value = xp_value
	pickup.position = position
	
	if pickup_container:
		pickup_container.add_child(pickup)
	else:
		add_child(pickup)


func _process(delta: float) -> void:
	if GameManager.game_state != GameManager.GameState.PLAYING:
		return
	
	# Spawn enemies during wave
	if GameManager.is_wave_active:
		spawn_timer += delta
		if spawn_timer >= spawn_interval:
			spawn_timer = 0.0
			spawn_enemy()


func _on_wave_started(wave_number: int) -> void:
	spawn_interval = max(0.2, 1.0 - wave_number * 0.05)  # Faster spawns in later waves


func _on_wave_ended(wave_number: int) -> void:
	pass
