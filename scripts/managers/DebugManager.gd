extends Node2D

var gravity := Vector2(0, 1)
var player_position := Vector2.ZERO
var camera_center_position := Vector2.ZERO
var camera_target_position := Vector2.ZERO
var camera_position := Vector2.ZERO
var touch_position := Vector2.ZERO
const arrow_legth := 100.0
const head_length := 40.0
const head_angle := 0.3 #rad
var clr := Color.RED

func _ready():
	GameManager.debugMngr = self

func _draw():
	draw_gravity_arrow()
	draw_player_position()
	draw_camera_position()
	draw_touch_position()

func draw_gravity_arrow():
	var origin = player_position
	draw_line(origin, origin + gravity, clr)
	var head : Vector2 = -(gravity).normalized() * head_length
	draw_line(origin + gravity, origin + gravity + head.rotated(head_angle),  clr)
	draw_line(origin + gravity, origin + gravity + head.rotated(-head_angle),  clr)

func draw_player_position():
	# draw_circle(player_position, 20, clr)
	pass

func draw_touch_position():
	draw_circle(touch_position, 20, clr)

func draw_camera_position():
	draw_circle(camera_center_position, 20, Color.BLUE)
	draw_circle(camera_target_position, 20, Color.YELLOW)

func set_gravity(dir: Vector2):
	gravity = arrow_legth * dir
	queue_redraw()

func set_player_position(position: Vector2):
	player_position = position
	queue_redraw()

func set_camera_position(center_position: Vector2, target_position: Vector2):
	camera_center_position = center_position
	camera_target_position = target_position
	queue_redraw()

func set_touch_position(position: Vector2):
	touch_position = position
	queue_redraw()
