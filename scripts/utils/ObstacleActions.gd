class_name ObstacleActions

static func on_collision(body):
	GameManager.player.queue_free()
