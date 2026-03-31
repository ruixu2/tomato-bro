extends CanvasLayer
## HUD - displays health, XP, level, wave, and other UI elements

@onready var health_bar: ProgressBar = $HealthBar
@onready var xp_bar: ProgressBar = $XPBar
@onready var level_label: Label = $LevelLabel
@onready var wave_label: Label = $WaveLabel
@onready var timer_label: Label = $TimerLabel
@onready var gold_label: Label = $GoldLabel
@onready var weapon_container: VBoxContainer = $WeaponContainer

var player: Node2D = null


func _ready() -> void:
	GameManager.wave_started.connect(_on_wave_started)
	GameManager.wave_ended.connect(_on_wave_ended)
	
	# Wait for player to be set up
	await get_tree().create_timer(0.5).timeout
	if GameManager.player:
		player = GameManager.player
		if player.has_signal("health_changed"):
			player.health_changed.connect(_on_health_changed)
		if player.has_signal("xp_changed"):
			player.xp_changed.connect(_on_xp_changed)
		
		update_level()
		update_health(player.health, player.max_health)
		update_xp(player.current_xp, player.xp_to_next_level)


func _process(delta: float) -> void:
	if GameManager.is_wave_active:
		timer_label.text = "Wave %d: %.1f" % [GameManager.current_wave, GameManager.wave_timer]


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


func _on_wave_started(wave_number: int) -> void:
	wave_label.text = "Wave %d" % wave_number


func _on_wave_ended(wave_number: int) -> void:
	pass
