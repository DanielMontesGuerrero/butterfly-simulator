extends Node

var playerMngr
var cameraMngr
var debugMngr
var timer
var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if playerMngr != null and cameraMngr != null:
		pass
		cameraMngr.position = playerMngr.position
		if debugMngr != null:
			debugMngr.set_player_position(playerMngr.position)
			debugMngr.set_camera_position(cameraMngr.get_screen_center_position(), cameraMngr.get_target_position())


func _on_timer_timeout():
	if playerMngr != null and rng.randi_range(0, 1) == 0:
		var angle = rng.randf_range(0, 2 * PI)
		var gravity_dir = Vector2(cos(angle), sin(angle))
		playerMngr.set_gravity(gravity_dir)
		if debugMngr != null:
			debugMngr.set_gravity(gravity_dir)
