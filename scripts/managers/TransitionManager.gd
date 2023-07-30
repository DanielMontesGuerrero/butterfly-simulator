extends Control


const game_scene := preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = GameManager.level
	match level:
		0:
			find_child("Chapter").set_text("Chapter " + str(level))
			find_child("Title").set_text("Shadows of nowhere")
		_:
			pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	GameManager.go_to_game()
