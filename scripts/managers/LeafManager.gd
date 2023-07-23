extends CharacterBody2D


const Movement := preload("res://scripts/utils/Movement.gd")

signal enemy_died(id)

var is_expanding := true
var is_shrinking := false
var is_following_player := false
var follow_speed := 700
var id: int
var timer
const change_size_speed := 0.01
const life_time = 30.0


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	timer = Timer.new()
	timer.wait_time = life_time
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	timer.one_shot = true
	add_child(timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_shrinking:
		scale.x -= change_size_speed
		scale.y -= change_size_speed
		if scale.x <= 0 or scale.y <= 0:
			free_and_emit()
	if is_expanding:
		scale.x += change_size_speed
		scale.y += change_size_speed
		if scale.x >= 1 or scale.y >= 1:
			scale = Vector2(1, 1)
			is_expanding = false
	if is_following_player:
		var direction = global_position.direction_to(GameManager.player_mngr.global_position)
		velocity += direction * follow_speed * delta
		move_and_slide()


func kill(fast_kill = false):
	if fast_kill:
		free_and_emit()
	is_shrinking = true
	is_expanding = false


func free_and_emit():
	enemy_died.emit(id)
	queue_free()


func _on_timer_timeout():
	kill()


func set_follow_enemy(should_follow: bool):
	is_following_player = should_follow
	velocity = Vector2.ZERO
