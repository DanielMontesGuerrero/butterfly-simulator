@tool
extends EditorScript


const MooreAutomataGenerator := preload("res://scripts/utils/MooreAutomataGenerator.gd")

@export var _seed := 1
@export var rows := 100
@export var cols := 100
@export var should_use_rand_seed := true
@export var fill_percent := 50
@export var is_edge_wall := true
@export var smooth_count := 20
@export var layer := 0
@export var terrain_set := 0
@export var terrain := 0
var rng: RandomNumberGenerator
var tilemap: TileMap


func _run():
	rng = RandomNumberGenerator.new()
	tilemap = get_scene().find_child("TileMap")
	gen_new_map()


func gen_new_map():
	if !Engine.is_editor_hint():
		return
	print("Generating new map")
	if should_use_rand_seed:
		_seed = rng.randi()
	print("Using config: ")
	print("Seed: ", _seed)
	print("Rows: ", rows)
	print("Cols: ", cols)
	print("Fill Percent: ", fill_percent)
	print("Smooth count: ", smooth_count)
	var matrix = MooreAutomataGenerator.gen_moore_cellular_automata(
		rows,
		cols,
		_seed,
		fill_percent,
		is_edge_wall,
		smooth_count,
	)
	tilemap.clear()
	var cells = []
	for i in matrix.size():
		for j in matrix[i].size():
			if matrix[i][j] == 1:
				cells.append(Vector2i(i, j))
	tilemap.set_cells_terrain_connect(layer, cells, terrain_set, terrain)
