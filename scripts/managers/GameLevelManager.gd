extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.sound_mngr.play_level_theme(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
