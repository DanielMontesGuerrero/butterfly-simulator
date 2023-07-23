extends Node2D


var game_over_scene: PackedScene = preload("res://scenes/game_finish.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(_body):
	get_tree().change_scene_to_packed(game_over_scene)
