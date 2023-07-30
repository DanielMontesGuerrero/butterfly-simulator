extends Node


const SoundManager := preload("res://scripts/managers/SoundManager.gd")

var level_mngr
var sound_mngr: SoundManager
var player_mngr
var camera_mngr
var debug_mngr
var game_status_mngr

var game_over_scene := preload("res://scenes/game_finish.tscn")
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
	get_tree().change_scene_to_packed(game_over_scene)


func go_to_game():
	get_tree().change_scene_to_packed(game_scene)


func go_to_start_menu():
	get_tree().change_scene_to_packed(start_menu_scene)
