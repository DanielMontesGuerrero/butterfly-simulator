class_name Utils


static func random_offset_vector(
	min_x = -1000,
	max_x = 1000,
	min_y = -1000,
	max_y = 1000,
):
	var rng = RandomNumberGenerator.new()
	return Vector2(rng.randf_range(min_x, max_x), rng.randf_range(min_y, max_y))
