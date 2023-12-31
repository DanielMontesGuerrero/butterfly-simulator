extends Node2D


const Leaf1 = preload("res://scenes/leaf_1.tscn")
const Leaf2 = preload("res://scenes/leaf_2.tscn")
const Leaf3 = preload("res://scenes/leaf_3.tscn")
const Leaf4 = preload("res://scenes/leaf_4.tscn")
const PathFollower = preload("res://scenes/random_path_follower.tscn")
const Utils = preload("res://scripts/utils/Utils.gd")

var id_count := 0
var timer
var rng
const spawn_rate := 3.0


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
	var enemy = create_random_enemy()
	add_child(enemy)

func create_random_enemy():
	var option = rng.randi_range(0, 2)
	var path_follower
	var enemy = create_random_type_enemy()
	var enemy_position = (GameManager.player_mngr.global_position
		+ Utils.random_offset_vector())
	if option == 0 or option == 1:
		path_follower = PathFollower.instantiate()
		path_follower.set_global_position(enemy_position)
		path_follower.curve = Curve2D.new()
		path_follower.set_new_path()
		path_follower.id = id_count
		path_follower.set_enemy_node(enemy)
	if option == 1:
		enemy.get_node("Area2D").body_entered.connect(path_follower._on_body_entered_enemy_area)
		enemy.get_node("Area2D").body_exited.connect(path_follower._on_body_exited_enemy_area)
	if option == 2:
		enemy.get_child(0).set_follow_enemy(true)
		enemy.set_global_position(enemy_position)

	enemy.get_child(0).enemy_died.connect(_handle_enemy_died)
	enemy.get_child(0).id = id_count
	id_count += 1

	if option == 0 or option == 1:
		return path_follower
	else:
		return enemy


func create_random_type_enemy():
	var random_num = rng.randi_range(0, 3)
	var enemy
	if random_num == 0:
		enemy = Leaf1.instantiate()
		enemy.scale = Vector2(0.03, 0.03)
	elif random_num == 1:
		enemy = Leaf2.instantiate()
		enemy.scale = Vector2(0.03, 0.03)
	elif random_num == 2:
		enemy = Leaf3.instantiate()
		enemy.scale = Vector2(0.3, 0.3)
	else:
		enemy = Leaf4.instantiate()
		enemy.scale = Vector2(0.04, 0.04)
	enemy.position = Vector2.ZERO
	return enemy


func _handle_enemy_died(_id):
	for child in get_children():
		if "id" in child and child.id == _id:
			child.queue_free()
			break
		if child.get_child_count() > 0 and "id" in child.get_child(0) and child.get_child(0).id == _id:
			child.queue_free()
			break
