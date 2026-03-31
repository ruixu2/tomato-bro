extends Node2D
class_name Weapon
## Base weapon controller - handles firing logic and projectile spawning

signal weapon_fired(weapon_data: WeaponData)
signal projectile_spawned(projectile: Node2D)

@export var weapon_data: WeaponData
@export var projectile_scene: PackedScene
@export var level: int = 1

var fire_timer: float = 0.0
var can_fire: bool = true
var is_active: bool = true
var player: Node2D = null
var current_target: Node2D = null

var _burst_counter: int = 0
var _burst_timer: float = 0.0
var _is_bursting: bool = false


func _ready() -> void:
	fire_timer = 0.0
	if weapon_data == null:
		weapon_data = WeaponData.new()


func _process(delta: float) -> void:
	if not is_active or not player or not player.is_alive:
		return
	
	# Handle bursting
	if _is_bursting:
		_burst_timer -= delta
		if _burst_timer <= 0:
			_fire_projectile()
			_burst_counter -= 1
			if _burst_counter <= 0:
				_is_bursting = false
			else:
				_burst_timer = weapon_data.burst_delay
		return
	
	# Find nearest enemy
	current_target = _find_nearest_enemy()
	
	if current_target:
		fire_timer += delta
		var current_fire_rate = weapon_data.get_fire_rate_at_level(level)
		
		if fire_timer >= 1.0 / current_fire_rate:
			fire_timer = 0.0
			_start_burst()


func _start_burst() -> void:
	if weapon_data.burst_count > 1:
		_is_bursting = true
		_burst_counter = weapon_data.burst_count
		_burst_timer = 0.0
		_fire_projectile()
		_burst_counter -= 1
	else:
		_fire_projectile()


func _fire_projectile() -> void:
	if not projectile_scene:
		return
	
	var effective_projectile_count = weapon_data.projectile_count
	
	for i in range(effective_projectile_count):
		var projectile = projectile_scene.instantiate()
		
		# Calculate spread angle
		var angle_offset = 0.0
		if weapon_data.spread_angle > 0:
			angle_offset = randf_range(-weapon_data.spread_angle / 2, weapon_data.spread_angle / 2)
		
		# Calculate direction to target with spread
		var direction: Vector2
		if current_target:
			direction = (current_target.global_position - global_position).normalized()
			direction = direction.rotated(deg_to_rad(angle_offset))
		else:
			direction = Vector2.RIGHT.rotated(deg_to_rad(angle_offset))
		
		# Setup projectile
		if projectile.has_method("setup"):
			projectile.setup(
				weapon_data.get_damage_at_level(level),
				weapon_data.projectile_speed,
				weapon_data.projectile_lifetime,
				direction,
				weapon_data.pierce,
				true,
				weapon_data.projectile_color,
				weapon_data.projectile_size,
				weapon_data.has_homing,
				weapon_data.homing_strength
			)
		
		# Add to projectile container
		var projectile_container = get_tree().get_first_node_in_group("projectile_container")
		if projectile_container:
			projectile_container.add_child(projectile)
		else:
			get_parent().add_child(projectile)
		
		projectile_spawned.emit(projectile)
	
	weapon_fired.emit(weapon_data)


func _find_nearest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest: Node2D = null
	var nearest_distance: float = INF
	
	for enemy in enemies:
		if enemy.is_alive if enemy.has_method("is_alive") else true:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest = enemy
	
	return nearest


func upgrade() -> void:
	level += 1


func get_stats() -> Dictionary:
	return {
		"name": weapon_data.weapon_name,
		"damage": weapon_data.get_damage_at_level(level),
		"fire_rate": weapon_data.get_fire_rate_at_level(level),
		"level": level
	}
