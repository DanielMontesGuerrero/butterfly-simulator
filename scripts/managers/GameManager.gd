extends Node

var playerMngr
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
func _process(delta):
	pass


func _on_timer_timeout():
	print("timeout")
	if playerMngr != null and rng.randi_range(0, 1) == 0:
		var angle = rng.randf_range(0, 2 * PI)
		var gravity_dir = Vector2(cos(angle), sin(angle))
		playerMngr.set_gravity(gravity_dir)
		debugMngr.set_gravity(gravity_dir)
