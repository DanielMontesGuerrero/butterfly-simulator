extends Node


const SoundManager := preload("res://scripts/managers/SoundManager.gd")

var player_mngr
var camera_mngr
var debug_mngr
var game_status_mngr
var sound_mngr: SoundManager
var score := 0
var timer
var rng

var game_over_scene := preload("res://scenes/game_finish.tscn")
var game_scene := preload("res://scenes/game.tscn")
var start_menu_scene := preload("res://scenes/start_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	rng = RandomNumberGenerator.new()
	sound_mngr = SoundManager.new()
	add_child(sound_mngr)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	score += 1
	if game_status_mngr != null:
		game_status_mngr.set_score(score)
		if player_mngr != null:
			game_status_mngr.set_live_icons(player_mngr.get_num_lives())
	if player_mngr != null and camera_mngr != null:
		pass
		camera_mngr.position = player_mngr.position
		if debug_mngr != null:
			debug_mngr.set_player_position(player_mngr.position)
			debug_mngr.set_camera_position(
				camera_mngr.get_screen_center_position(),
				camera_mngr.get_target_position(),
			)


func _on_timer_timeout():
	if player_mngr != null and rng.randi_range(0, 1) == 0:
		var angle = rng.randf_range(0, 2 * PI)
		var gravity_dir = Vector2(cos(angle), sin(angle))
		player_mngr.set_gravity(gravity_dir)
		if debug_mngr != null:
			debug_mngr.set_gravity(gravity_dir)
		sound_mngr.play_background_effect("blow")


func end_game():
	get_tree().change_scene_to_packed(game_over_scene)


func go_to_game():
	get_tree().change_scene_to_packed(game_scene)


func go_to_start_menu():
	get_tree().change_scene_to_packed(start_menu_scene)
