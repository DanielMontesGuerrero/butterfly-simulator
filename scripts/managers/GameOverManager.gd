extends Control


@export var start_game_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.sound_mngr.play_game_over_theme()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if (event is InputEventKey) or (event is InputEventMouseButton):
		if event.pressed:
			GameManager.go_to_start_menu()
