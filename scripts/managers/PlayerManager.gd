extends CharacterBody2D


const Butterfly = preload("res://scripts/utils/Butterfly.gd")

var butterfly := Butterfly.new()
var is_inmune := false
var timer: Timer
const INMUNE_TIME := 3.0


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_mngr = self
	timer = Timer.new()
	timer.wait_time = INMUNE_TIME
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(set_not_inmune)
	add_child(timer)


func _input(event):
	if event.is_action_pressed("controlls_touch"):
		butterfly.position = self.position
		var touch_position = (GameManager.camera_mngr
			.to_global(event.position - get_viewport_rect().size / 2) 
			- GameManager.camera_mngr.get_target_position()
			+ GameManager.camera_mngr.get_screen_center_position())
		GameManager.debug_mngr.set_touch_position(touch_position)
		butterfly.directed_jump(touch_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	butterfly.process(delta)
	var collision = move_and_collide(butterfly.velocity)
	if collision != null:
		var body = collision.get_collider()
		if body.is_in_group("Leaf"):
			receive_damage()


func set_gravity(gravity_dir: Vector2):
	butterfly.set_gravity(gravity_dir)


func get_num_lives():
	return butterfly.num_lives


func receive_damage():
	if is_inmune:
		return
	butterfly.receive_damage()
	if butterfly.num_lives < 0:
		GameManager.end_game()
	else:
		set_inmune()


func collect_item(item_type: String):
	match item_type:
		"heart":
			butterfly.add_live()
		_:
			pass


func set_inmune():
	is_inmune = true
	timer.start()
	play_blink()


func set_not_inmune():
	is_inmune = false
	stop_blink()


func play_blink():
	get_node("AnimationPlayer").play("blink")
	
	
func stop_blink():
	get_node("AnimationPlayer").stop()
