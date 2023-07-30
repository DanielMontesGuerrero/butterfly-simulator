extends Node2D


var wind_gust_mngrs: Array
var score := 0
var timer
var rng
var wind_gust_scene := preload("res://scenes/wind_gust.tscn")
var wind_gust_timer: Timer

const WIND_GUST_INTERVAL := 3
const GRAVITY_CHANGE_INTERVAL := 3
const NUM_WIND_GUSTS = 3
const SCORE_INCREASE = 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.level_mngr = self
	GameManager.sound_mngr.play_level_theme(0)
	
	timer = Timer.new()
	timer.wait_time = GRAVITY_CHANGE_INTERVAL
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

	rng = RandomNumberGenerator.new()
	
	wind_gust_timer = Timer.new()
	wind_gust_timer.wait_time = WIND_GUST_INTERVAL
	wind_gust_timer.autostart = true
	wind_gust_timer.one_shot = false
	wind_gust_timer.timeout.connect(_on_wind_gust_timer_timeout)
	add_child(wind_gust_timer)
	
	wind_gust_mngrs = []
	for i in NUM_WIND_GUSTS:
		wind_gust_mngrs.append(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	score += 1
	if GameManager.game_status_mngr != null:
		GameManager.game_status_mngr.set_score(score)
		if GameManager.player_mngr != null:
			GameManager.game_status_mngr.set_live_icons(GameManager.player_mngr.get_num_lives())
	if GameManager.player_mngr != null and GameManager.camera_mngr != null:
		pass
		GameManager.camera_mngr.position = GameManager.player_mngr.position
		if GameManager.debug_mngr != null:
			GameManager.debug_mngr.set_player_position(GameManager.player_mngr.position)
			GameManager.debug_mngr.set_camera_position(
				GameManager.camera_mngr.get_screen_center_position(),
				GameManager.camera_mngr.get_target_position(),
			)


func _on_timer_timeout():
	if GameManager.player_mngr != null and rng.randi_range(0, 1) == 0:
		var angle = rng.randf_range(0, 2 * PI)
		var gravity_dir = Vector2(cos(angle), sin(angle))
		GameManager.player_mngr.set_gravity(gravity_dir)
		if GameManager.debug_mngr != null:
			GameManager.debug_mngr.set_gravity(gravity_dir)
		GameManager.sound_mngr.play_background_effect("blow")
		show_wind_gust(true)


func _on_wind_gust_timer_timeout():
	show_wind_gust(false)


func show_wind_gust(force: bool):
	if force:
		for mngr in wind_gust_mngrs:
			if mngr != null:
				mngr.free()
		wind_gust_mngrs.clear()
	if (wind_gust_mngrs.is_empty()
		or (not wind_gust_mngrs.is_empty() && wind_gust_mngrs[0] != null)
		or force):
		wind_gust_mngrs.clear()
		for i in NUM_WIND_GUSTS:
			var mngr = wind_gust_scene.instantiate()
			wind_gust_mngrs.append(mngr)
			get_node("UILayer").add_child(mngr)
	else:
		return
	var angle = GameManager.player_mngr.butterfly.gravity_velocity.angle()
	if angle < 0:
		angle += 2 * PI
	for mngr in wind_gust_mngrs:
		mngr.find_child("Path2D").set_rotation(angle)
		var offset_len = get_viewport_rect().size / 6
		var offset = Vector2(
			rng.randf_range(-offset_len.x, offset_len.x),
			rng.randf_range(-offset_len.y, offset_len.y))
		var pos = get_viewport_rect().size / 4
		mngr.set_position(pos + offset)


func increase_score():
	score += SCORE_INCREASE
