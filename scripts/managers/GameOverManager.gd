extends Control


@export var start_game_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if (event is InputEventKey) or (event is InputEventMouseButton):
		if event.pressed:
			get_tree().change_scene_to_packed(start_game_scene)