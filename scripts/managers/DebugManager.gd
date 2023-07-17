extends Node2D

var gravity := Vector2(0, 1)
var origin := Vector2(200, 200)
const arrow_legth = 100.0
const head_length = 40.0
const head_angle = 0.3 #rad
var clr := Color.RED

func _ready():
	GameManager.debugMngr = self

func _draw():
	draw_gravity_arrow()

func draw_gravity_arrow():
	draw_line(origin, origin + gravity, clr)
	var head : Vector2 = -(gravity).normalized() * head_length
	draw_line(origin + gravity, origin + gravity + head.rotated(head_angle),  clr)
	draw_line(origin + gravity, origin + gravity + head.rotated(-head_angle),  clr)

func set_gravity(dir):
	gravity = arrow_legth * dir
	queue_redraw()
