extends CharacterBody2D

const Movement := preload("res://scripts/utils/Movement.gd")

var bezier_t := 0.0
var p0 := Vector2(-500, -250)
var p1 := Vector2(0, 300)
var p2 := Vector2(500, -300)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bezier_t += delta
	if bezier_t <= 1.0:
		var next_bezier_point = Movement.quadratic_bezier(p0, p1, p2, bezier_t)
		var velocity = next_bezier_point - position
		position = next_bezier_point
		# move_and_collide(velocity)
