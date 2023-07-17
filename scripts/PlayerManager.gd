extends RigidBody2D

var speed = 1
var gravity = 2
var fly_velocity = 3
var velocity = Vector2()
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player = self

func get_input():
	if Input.is_action_pressed("ui_spacebar"):
		velocity.y = -fly_velocity
		
func _input(event):
	if event.is_action_pressed("ui_mouse_click"):
		print(event.position)
		print(self.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score += 1
	GameManager.score.set_text(str(score))
	velocity.x = speed
	velocity.y = gravity
	get_input()
	move_and_collide(velocity)
