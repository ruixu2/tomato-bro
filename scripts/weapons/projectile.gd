extends Area2D
class_name Projectile
## Enhanced projectile with homing, visual customization, and pooling support

@export var damage: float = 10.0
@export var speed: float = 300.0
@export var lifetime: float = 3.0
@export var pierce: int = 0
@export var is_player_projectile: bool = true
@export var has_homing: bool = false
@export var homing_strength: float = 0.0

var direction: Vector2 = Vector2.RIGHT
var enemies_hit: Array = []
var homing_target: Node2D = null
var projectile_color: Color = Color.YELLOW
var projectile_size: Vector2 = Vector2(8, 8)

var _sprite: Sprite2D
var _lifetime_timer: float = 0.0


func _ready() -> void:
	# Setup collision
	collision_layer = 4 if is_player_projectile else 8
	collision_mask = 2 if is_player_projectile else 1
	
	# Connect signals
	body_entered.connect(_on_body_entered)
	
	# Create sprite if not exists
	if not has_node("Sprite"):
		_sprite = Sprite2D.new()
		_sprite.name = "Sprite"
		add_child(_sprite)
	else:
		_sprite = $Sprite
	
	# Create collision shape
	if not has_node("CollisionShape2D"):
		var collision = CollisionShape2D.new()
		collision.name = "CollisionShape2D"
		var shape = RectangleShape2D.new()
		shape.size = projectile_size
		collision.shape = shape
		add_child(collision)
	
	_lifetime_timer = lifetime


func setup(
	p_damage: float,
	p_speed: float,
	p_lifetime: float,
	p_direction: Vector2,
	p_pierce: int,
	p_is_player: bool,
	p_color: Color,
	p_size: Vector2,
	p_has_homing: bool,
	p_homing_strength: float
) -> void:
	damage = p_damage
	speed = p_speed
	lifetime = p_lifetime
	direction = p_direction
	pierce = p_pierce
	is_player_projectile = p_is_player
	projectile_color = p_color
	projectile_size = p_size
	has_homing = p_has_homing
	homing_strength = p_homing_strength
	
	# Update visual
	if _sprite:
		_sprite.modulate = projectile_color
	
	# Update collision shape
	if has_node("CollisionShape2D"):
		var shape = $CollisionShape2D.shape
		if shape:
			shape.size = projectile_size


func _process(delta: float) -> void:
	_lifetime_timer -= delta
	if _lifetime_timer <= 0:
		queue_free()
		return
	
	# Homing logic
	if has_homing and is_player_projectile:
		_apply_homing(delta)
	
	# Move projectile
	position += direction * speed * delta
	
	# Rotate to face direction
	rotation = direction.angle()


func _apply_homing(delta: float) -> void:
	# Find or update target
	if not homing_target or not homing_target.is_alive if homing_target.has_method("is_alive") else homing_target:
		homing_target = _find_nearest_enemy()
	
	if homing_target:
		var target_direction = (homing_target.global_position - global_position).normalized()
		# Smoothly rotate towards target
		direction = direction.lerp(target_direction, homing_strength * delta)
		direction = direction.normalized()


func _find_nearest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest: Node2D = null
	var nearest_distance: float = INF
	
	for enemy in enemies:
		if enemy.is_alive if enemy.has_method("is_alive") else true:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < nearest_distance and distance < 200:  # Homing range
				nearest_distance = distance
				nearest = enemy
	
	return nearest


func _on_body_entered(body: Node2D) -> void:
	if is_player_projectile:
		# Check if hitting enemy
		if body.is_in_group("enemies") and body not in enemies_hit:
			enemies_hit.append(body)
			if body.has_method("take_damage"):
				body.take_damage(damage)
			
			pierce -= 1
			if pierce < 0:
				queue_free()
	else:
		# Check if hitting player
		if body.is_in_group("players") and body.has_method("take_damage"):
			body.take_damage(damage)
			queue_free()


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
