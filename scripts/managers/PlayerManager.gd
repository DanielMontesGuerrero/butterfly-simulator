extends CharacterBody2D


const Butterfly = preload("res://scripts/utils/Butterfly.gd")

var butterfly := Butterfly.new()
var is_inmune := false
var animation_direction := false
var timer: Timer
var animation_timer: Timer
const INMUNE_TIME := 3.0
const JUMP_ANIMATION_LENGTH := 0.5
const MAX_VISIBILITY := 40
const VISIBILITY_INCREASE := 10


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_mngr = self
	timer = Timer.new()
	timer.wait_time = INMUNE_TIME
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(set_not_inmune)
	add_child(timer)

	animation_timer = Timer.new()
	animation_timer.wait_time = JUMP_ANIMATION_LENGTH
	animation_timer.autostart = false
	animation_timer.one_shot = true
	animation_timer.timeout.connect(animate_idle)
	add_child(animation_timer)

	GameManager.sound_mngr.set_pe_players([
		get_node("AudioStreamPlayer2D"),
		get_node("AudioStreamPlayer2D2"),
	])


func _input(event):
	if event.is_action_pressed("controlls_touch"):
		butterfly.position = self.position
		var touch_position = (GameManager.camera_mngr
			.to_global(event.position - get_viewport_rect().size / 2) 
			- GameManager.camera_mngr.get_target_position()
			+ GameManager.camera_mngr.get_screen_center_position())
		GameManager.debug_mngr.set_touch_position(touch_position)
		var jump_direction = touch_position - position
		animation_direction = (jump_direction).x > 0
		butterfly.directed_jump(jump_direction)
		animate_jump(jump_direction)
		GameManager.sound_mngr.play_player_effect("jump")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	butterfly.process(delta)
	var collision = move_and_collide(butterfly.velocity)
	if collision != null:
		butterfly.bounce(collision)
		var body = collision.get_collider()
		if body.is_in_group("Leaf"):
			body.kill(true)
			receive_damage()
		if body.is_in_group("Wall"):
			GameManager.sound_mngr.play_player_effect("bounce")


func set_sprite_direction():
	get_node("AnimatedSprite2D").set_flip_h(animation_direction)


func animate_jump(jump_direction: Vector2):
	set_sprite_direction()
	if jump_direction.y < 0:
		get_node("AnimatedSprite2D").play("flutter")
	else:
		get_node("AnimatedSprite2D").play("flutter_down")
	animation_timer.start()


func animate_idle():
	set_sprite_direction()
	get_node("AnimatedSprite2D").play("idle")


func set_gravity(gravity_dir: Vector2):
	butterfly.set_gravity(gravity_dir)


func get_num_lives():
	return butterfly.num_lives


func receive_damage():
	if is_inmune:
		return
	butterfly.receive_damage()
	GameManager.sound_mngr.play_player_effect("damage")
	if butterfly.num_lives < 0:
		GameManager.end_game()
	else:
		set_inmune()


func collect_item(item_type: String):
	match item_type:
		"heart":
			butterfly.add_live()
		"orbe":
			increase_visibility()
		"flower":
			GameManager.level_mngr.increase_score()
		"star":
			GameManager.win_game()
		_:
			pass


func increase_visibility():
	var old_scale = get_node("PointLight2D").get_scale()
	var new_scale = Vector2(
		old_scale.x + VISIBILITY_INCREASE,
		old_scale.y + VISIBILITY_INCREASE)
	get_node("PointLight2D").set_scale(new_scale)


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
