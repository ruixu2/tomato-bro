extends CanvasLayer
## HUD - displays health, XP, level, wave, weapons, and other UI elements

@onready var health_bar: ProgressBar = $HealthBar
@onready var xp_bar: ProgressBar = $XPBar
@onready var level_label: Label = $LevelLabel
@onready var wave_label: Label = $WaveLabel
@onready var timer_label: Label = $TimerLabel
@onready var gold_label: Label = $GoldLabel
@onready var weapon_container: VBoxContainer = $WeaponContainer
@onready var dps_label: Label = $DPSLabel
@onready var speedup_label: Label = $SpeedupLabel
@onready var speedup_button: Button = $SpeedupButton

var player: Node2D = null
var weapon_manager: WeaponManager = null


func _ready() -> void:
	GameManager.wave_started.connect(_on_wave_started)
	GameManager.wave_ended.connect(_on_wave_ended)
	
	# Connect speedup button
	if speedup_button:
		speedup_button.pressed.connect(_on_speedup_button_pressed)
	
	# Wait for player to be set up
	await get_tree().create_timer(0.5).timeout
	if GameManager.player:
		player = GameManager.player
		if player.has_signal("health_changed"):
			player.health_changed.connect(_on_health_changed)
		if player.has_signal("xp_changed"):
			player.xp_changed.connect(_on_xp_changed)
		if player.has_signal("weapon_manager_ready"):
			player.weapon_manager_ready.connect(_on_weapon_manager_ready)
		
		update_level()
		update_health(player.health, player.max_health)
		update_xp(player.current_xp, player.xp_to_next_level)


func _process(delta: float) -> void:
	if GameManager.is_wave_active:
		timer_label.text = "Wave %d: %.1f" % [GameManager.current_wave, GameManager.wave_timer]
	
	# Update DPS display
	if weapon_manager:
		dps_label.text = "DPS: %.1f" % weapon_manager.get_total_dps()
	
	# Update speedup status
	if speedup_label:
		if GameManager.wave_speedup_enabled:
			speedup_label.text = "⏩ 2x SPEED"
			speedup_label.modulate = Color(1, 1, 0, 1)  # Yellow
		else:
			speedup_label.text = "⏸ NORMAL"
			speedup_label.modulate = Color(1, 1, 1, 1)  # White


func update_health(current: int, max_val: int) -> void:
	if health_bar:
		health_bar.max_value = max_val
		health_bar.value = current


func update_xp(current: int, max_val: int) -> void:
	if xp_bar:
		xp_bar.max_value = max_val
		xp_bar.value = current


func update_level() -> void:
	if level_label and player:
		level_label.text = "Lv.%d" % player.level


func update_gold() -> void:
	if gold_label:
		gold_label.text = "Gold: %d" % GameManager.gold


func _on_health_changed(new_health: int, max_health: int) -> void:
	update_health(new_health, max_health)


func _on_xp_changed(current_xp: int, max_xp: int) -> void:
	update_xp(current_xp, max_xp)
	update_level()


func _on_weapon_manager_ready(manager: WeaponManager) -> void:
	weapon_manager = manager
	_update_weapon_display()


func _on_wave_started(wave_number: int) -> void:
	wave_label.text = "Wave %d" % wave_number


func _on_wave_ended(wave_number: int) -> void:
	pass


func _on_speedup_button_pressed() -> void:
	GameManager.toggle_wave_speedup()


func _input(event: InputEvent) -> void:
	# Press V to toggle speedup
	if event is InputEventKey and event.pressed and event.keycode == KEY_V:
		GameManager.toggle_wave_speedup()


func _update_weapon_display() -> void:
	if not weapon_container or not weapon_manager:
		return
	
	# Clear existing weapon labels
	for child in weapon_container.get_children():
		child.queue_free()
	
	# Display weapon info
	var weapons = weapon_manager.get_all_weapons()
	for weapon in weapons:
		var label = Label.new()
		label.text = "%s (Lv.%d)" % [weapon.weapon_data.weapon_name, weapon.level]
		weapon_container.add_child(label)
