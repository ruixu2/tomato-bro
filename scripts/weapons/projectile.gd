extends Area2D
## Projectile script - handles projectile movement and collision

@export var damage: float = 10.0
@export var speed: float = 300.0
@export var lifetime: float = 3.0
@export var pierce: int = 0
@export var is_player_projectile: bool = true

var direction: Vector2 = Vector2.RIGHT
var enemies_hit: Array = []


func _ready() -> void:
	# Auto-destroy after lifetime
	var timer = get_tree().create_timer(lifetime)
	timer.timeout.connect(_on_lifetime_timeout)
	
	# Connect body entered signal
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_lifetime_timeout() -> void:
	queue_free()


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
