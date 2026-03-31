extends Node2D
## Base weapon script - handles weapon behavior and firing

signal projectile_spawned(projectile)

@export var weapon_name: String = "Base Weapon"
@export var damage: float = 10.0
@export var fire_rate: float = 1.0  # shots per second
@export var projectile_speed: float = 300.0
@export var projectile_lifetime: float = 3.0
@export var projectile_scene: PackedScene
@export var attack_speed_mult: float = 1.0
@export var damage_mult: float = 1.0

var fire_timer: float = 0.0
var can_fire: bool = true
var is_active: bool = true

var player: Node2D = null


func _ready() -> void:
	fire_timer = 0.0


func _process(delta: float) -> void:
	if not is_active or not player:
		return
	
	# Find player if not set
	if not player:
		player = get_parent()
		return
	
	fire_timer += delta
	var actual_fire_rate = fire_rate * attack_speed_mult
	
	if fire_timer >= 1.0 / actual_fire_rate:
		fire()
		fire_timer = 0.0


func fire() -> void:
	if not can_fire:
		return
	
	shoot()


func shoot() -> void:
	# Override in weapon-specific scripts
	pass


func get_effective_damage() -> float:
	return damage * damage_mult
