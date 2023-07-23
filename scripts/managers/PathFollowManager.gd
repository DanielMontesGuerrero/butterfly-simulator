extends PathFollow2D


var speed := 200
var follow_speed := 300
var is_following_enemy := true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_following_enemy:
		set_progress(get_progress() + follow_speed * delta)
	else:
		set_progress(get_progress() + speed * delta)
	if get_progress_ratio() >= 1.0:
		get_parent().set_new_path()
		set_progress(0)


func set_follow_path(should_follow: bool):
	is_following_enemy = should_follow
	set_progress(0)
