extends CharacterBody2D
## Base enemy script - handles AI movement and basic stats

signal died(enemy)

@export var max_health: int = 10
@export var health: int = 10
@export var move_speed: float = 50.0
@export var damage: int = 5
@export var xp_value: int = 1

var player: Node2D = null
var is_alive: bool = true


func _ready() -> void:
	# Find player reference
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(_on_find_player_timeout)


func _on_find_player_timeout() -> void:
	if GameManager.player:
		player = GameManager.player


func _physics_process(delta: float) -> void:
	if not is_alive or not player or not player.is_alive:
		return
	
	# Move towards player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * move_speed
	
	# Simple collision avoidance
	move_and_slide()


func take_damage(amount: float) -> void:
	if not is_alive:
		return
	
	health -= int(amount)
	if health <= 0:
		die()


func die() -> void:
	is_alive = false
	GameManager.on_enemy_defeated()
	died.emit(self)
	queue_free()


func deal_damage_to_player() -> void:
	if player and player.is_alive:
		player.take_damage(damage)
