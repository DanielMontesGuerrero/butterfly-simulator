class_name ObstacleActions


static func on_collision(body):
	if body.is_in_group("Leaf"):
		body.kill()
