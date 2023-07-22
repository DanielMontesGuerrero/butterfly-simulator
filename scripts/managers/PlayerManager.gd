extends CharacterBody2D


const Butterfly = preload("res://scripts/utils/Butterfly.gd")

var butterfly := Butterfly.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.playerMngr = self


func _input(event):
	if event.is_action_pressed("controlls_touch"):
		butterfly.position = self.position
		var touch_position = (GameManager.cameraMngr.to_global(event.position - get_viewport_rect().size / 2) 
			- GameManager.cameraMngr.get_target_position()
			+ GameManager.cameraMngr.get_screen_center_position())
		GameManager.debugMngr.set_touch_position(touch_position)
		butterfly.directed_jump(touch_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	butterfly.process(delta)
	move_and_collide(butterfly.velocity)


func set_gravity(gravity_dir: Vector2):
	butterfly.set_gravity(gravity_dir)
