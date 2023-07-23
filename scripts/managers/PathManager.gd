extends Path2D


const Movement := preload("res://scripts/utils/Movement.gd")

var id: int
var is_following_player := false
var enemy
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
	var new_curve
	if is_following_player:
		new_curve = Movement.get_directed_curve(GameManager.player_mngr.global_position - global_position)
	else:
		new_curve = Movement.get_random_curve()
	self.get_curve().clear_points()
	for bezier_point in new_curve:
		self.get_curve().add_point(
			bezier_point[0],
			bezier_point[1],
			bezier_point[2],
		)


func set_enemy_node(_enemy):
	enemy = _enemy
	get_child(0).add_child(enemy)


func _on_body_entered_enemy_area(body):
	if body.is_in_group("Player"):
		is_following_player = true
		set_new_path()
		get_node("PathFollow2D").set_follow_path(true)


func _on_body_exited_enemy_area(body):
	if body.is_in_group("Player"):
		is_following_player = false
		set_new_path()
		get_node("PathFollow2D").set_follow_path(false)
