extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.sound_mngr.play_intro_theme()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	GameManager.go_to_game()
