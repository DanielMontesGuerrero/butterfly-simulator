extends CharacterBody2D


const Butterfly = preload("res://scripts/utils/Butterfly.gd")

var butterfly := Butterfly.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_mngr = self


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
	move_and_collide(butterfly.velocity)


func set_gravity(gravity_dir: Vector2):
	butterfly.set_gravity(gravity_dir)


func get_num_lives():
	return butterfly.num_lives


func receive_damage():
	butterfly.receive_damage()
	if butterfly.num_lives <= 0:
		GameManager.end_game()
