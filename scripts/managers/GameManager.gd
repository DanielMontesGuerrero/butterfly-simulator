extends Node


const SoundManager := preload("res://scripts/managers/SoundManager.gd")

var total_score := 0
var level := 0
var level_mngr
var sound_mngr: SoundManager
var player_mngr
var camera_mngr
var debug_mngr
var game_status_mngr

var transition_scene := preload("res://scenes/transition.tscn")
var game_over_scene := preload("res://scenes/game_finish.tscn")
var win_scene := preload("res://scenes/win_game.tscn")
var game_scene := preload("res://scenes/game.tscn")
var start_menu_scene := preload("res://scenes/start_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	sound_mngr = SoundManager.new()
	add_child(sound_mngr)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func end_game():
	total_score = level_mngr.score
	get_tree().change_scene_to_packed(game_over_scene)


func go_to_level(_level: int):
	level = _level
	get_tree().change_scene_to_packed(transition_scene)


func go_to_game():
	get_tree().change_scene_to_packed(game_scene)


func go_to_start_menu():
	get_tree().change_scene_to_packed(start_menu_scene)


func win_game():
	total_score = level_mngr.score
	get_tree().change_scene_to_packed(win_scene)
