extends Node2D


@export var collectable_type: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		GameManager.sound_mngr.play_player_effect("collect_" + collectable_type)
		body.collect_item(collectable_type)
		queue_free()
