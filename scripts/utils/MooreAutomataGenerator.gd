class_name MooreAutomataGenerator


static func gen_moore_cellular_automata(
	rows: int,
	cols: int,
	_seed: int,
	fill_percent: int,
	is_edge_wall: bool,
	smooth_count: int):
	var matrix = gen_cellular_automata(rows, cols, _seed, fill_percent, is_edge_wall)
	for i in smooth_count:
		for y in rows:
			for x in cols:
				var sorrounding_tiles_count = get_moore_surrounding_tiles(matrix, x, y)
				if (is_edge_wall
					and (x == 0 or (x + 1) == matrix.size() or y == 0 or (y + 1) == matrix[x].size())):
					matrix[x][y] = 1
				elif sorrounding_tiles_count > 4:
					matrix[x][y] = 1
				elif sorrounding_tiles_count < 4:
					matrix[x][y] = 0
	return matrix


static func get_moore_surrounding_tiles(matrix: Array, i: int, j: int):
	var tile_count = 0
	for x in range(i - 1, i + 2):
		for y in range(j - 1, j + 2):
			if x >= 0 and x < matrix.size() and y >= 0 and y < matrix[i].size():
				if x != i or y != j:
					tile_count += matrix[x][y]
	return tile_count


static func gen_matrix(rows: int, cols: int, should_fill_matrix: bool):
	var matrix = []
	for i in rows:
		var row = []
		for j in cols:
			if should_fill_matrix:
				row.append(1)
			else:
				row.append(0)
		matrix.append(row)
	return matrix


static func gen_cellular_automata(
	rows: int,
	cols: int,
	_seed: int,
	fill_percent: int,
	is_edge_wall: bool):
	var matrix = gen_matrix(rows, cols, false)
	var rng = RandomNumberGenerator.new()
	rng.set_seed(_seed)
	for i in range(matrix.size()):
		for j in range(matrix[i].size()):
			if (is_edge_wall
				and (i == 0 or (i + 1) == matrix.size() or j == 0 or (j + 1) == matrix[i].size())):
				matrix[i][j] = 1
			else:
				var val = 0
				if rng.randi_range(0, 100) < fill_percent:
					val = 1
				matrix[i][j] = val
	return matrix
