class_name Butterfly

var velocity: Vector2
var position: Vector2
var is_jumping: bool
var jump_velocity: Vector2
var gravity_velocity: Vector2
const jump_speed_factor := 5
const gravity_factor := 10
const stop_factor := 0.01
const EPS := 1e-9

func sgn(x: float):
	if(x > 0):
		return 1
	elif(x < 0):
		return -1
	return 0

func _init():
	velocity = Vector2.ZERO
	position = Vector2.ZERO
	is_jumping = false
	jump_velocity = Vector2.ZERO
	gravity_velocity = gravity_factor * Vector2(0, 1)

func process(delta: float):
	if is_jumping:
		is_jumping = false
	else:
		if jump_velocity.length() > EPS:
			velocity -= stop_factor * jump_velocity
			jump_velocity -= stop_factor * jump_velocity
		velocity += delta * gravity_velocity


func directed_jump(direction_point: Vector2):
	is_jumping = true
	var direction = direction_point - position
	var jump_inc = jump_speed_factor * direction.normalized()
	if sgn(velocity.x) != sgn(jump_inc.x) and sgn(velocity.x) != 0:
		velocity.x = 0
		jump_velocity.x = 0
	if sgn(velocity.y) != sgn(jump_inc.y) and sgn(velocity.y) != 0:
		velocity.y = 0
		jump_velocity.y = 0
	velocity += jump_inc
	jump_velocity += jump_inc


func set_gravity(dir):
	gravity_velocity = gravity_factor * dir
