extends Control


@export var start_game_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.sound_mngr.play_game_over_theme()
	find_child("ScoreLabel").set_text(str(GameManager.total_score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if event.is_action_pressed("ui_accept"):
		GameManager.go_to_start_menu()
