class_name Movement


const MIN_DELTA = -1000
const MAX_DELTA = 1000
const NUM_POINTS = 3

static func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r


static func cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)

	var s = r0.lerp(r1, t)
	return s


static func get_random_curve():
	var rng = RandomNumberGenerator.new()
	var points = []
	for i in NUM_POINTS:
		var dx = rng.randf_range(MIN_DELTA, MAX_DELTA)
		var dy = rng.randf_range(MIN_DELTA, MAX_DELTA)
		var point = Vector2(dx, dy)
		if not points.is_empty():
			point = points.back() + point
		points.append(Vector2(dx, dy))
	var curve = [[Vector2.ZERO, Vector2.ZERO, points[0]]]
	for i in range(1, NUM_POINTS - 2, 3):
		if i + 2 >= NUM_POINTS:
			break
		curve.append([points[i], points[i + 1], points[i + 2]])
	curve.append([points[NUM_POINTS - 2], points[NUM_POINTS - 1], Vector2.ZERO])
	return curve
