extends Node2D


const HeartCollectable = preload("res://scenes/heart_collectable.tscn")
const FlowerCollectable = preload("res://scenes/flower_collectable.tscn")
const OrbeCollectable = preload("res://scenes/orbe_collectable.tscn")
const Utils = preload("res://scripts/utils/Utils.gd")

var spawn_rate := 3.0
var rng: RandomNumberGenerator
var timer: Timer

const MAX_NUM_COLLECTABLES := 20


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = spawn_rate
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	# timer.one_shot = true
	add_child(timer)
	rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	if get_child_count() < MAX_NUM_COLLECTABLES:
		var collectable = create_random_collectable()
		add_child(collectable)


func create_random_collectable():
	var collectable = create_random_type_collectable()
	collectable.global_position = (GameManager.player_mngr.global_position
		+ Utils.random_offset_vector())
	return collectable


func create_random_type_collectable():
	var random_num = rng.randi_range(0, 2)
	var collectable
	match random_num:
		0:
			collectable = HeartCollectable.instantiate()
			collectable.scale = Vector2(0.02, 0.02)
		2:
			collectable = FlowerCollectable.instantiate()
			collectable.scale = Vector2(0.1, 0.1)
		1:
			collectable = OrbeCollectable.instantiate()
			collectable.scale = Vector2(0.05, 0.05)
		_:
			return null
	return collectable
