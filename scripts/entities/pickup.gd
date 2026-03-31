extends Area2D
## Pickup script - handles XP orb collection

@export var xp_value: int = 1
@export var move_speed: float = 150.0
@export var pickup_range: float = 100.0

var player: Node2D = null
var is_moving_to_player: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	# Find player
	var timer = get_tree().create_timer(0.5)
	timer.timeout.connect(_on_find_player_timeout)


func _on_find_player_timeout() -> void:
	if GameManager.player:
		player = GameManager.player
		pickup_range = player.pickup_range if player.has_method("get") or player.has_signal("pickup_range") else 100.0


func _process(delta: float) -> void:
	if not player or not player.is_alive:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Check if in pickup range
	if distance_to_player < pickup_range:
		is_moving_to_player = true
	
	if is_moving_to_player:
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * move_speed * delta
		
		# Check if collected
		if distance_to_player < 20:
			collect()


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		collect()


func collect() -> void:
	if player and player.has_method("add_xp"):
		player.add_xp(xp_value)
	queue_free()
