extends Path2D

const Movement := preload("res://scripts/utils/Movement.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_new_path():
	var new_position = get_child(0).get_child(0).global_position
	# var new_position = to_global(character_position)
	position = new_position
	var curve = Movement.get_random_curve()
	get_curve().clear_points()
	for bezier_point in curve:
		get_curve().add_point(
			bezier_point[0],
			bezier_point[1],
			bezier_point[2],
		)

