extends Path2D


const Movement := preload("res://scripts/utils/Movement.gd")

var id: int
var timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func set_new_path():
	if get_child(0).get_child_count() > 0:
		var new_position = get_child(0).get_child(0).global_position
		set_global_position(new_position)
	var new_curve = Movement.get_random_curve()
	self.get_curve().clear_points()
	for bezier_point in new_curve:
		self.get_curve().add_point(
			bezier_point[0],
			bezier_point[1],
			bezier_point[2],
		)


func set_enemy_node(enemy):
	get_child(0).add_child(enemy)
