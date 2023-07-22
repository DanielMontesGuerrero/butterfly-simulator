extends PathFollow2D


var speed := 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_progress(get_progress() + speed * delta)
	if get_progress_ratio() >= 1.0:
		get_parent().set_new_path()
		set_progress(0)
