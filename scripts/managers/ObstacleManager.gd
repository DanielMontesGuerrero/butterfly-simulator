extends Node2D


const ObstacleActions := preload("res://scripts/utils/ObstacleActions.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	ObstacleActions.on_collision(body)
