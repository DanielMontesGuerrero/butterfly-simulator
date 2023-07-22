extends Control


@export var texture: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.game_status_mngr = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func set_score(score: int):
	var score_number = get_node("MenuContainer/ScoreContaimer/MarginContainer/"
		+ "HBoxContainer2/ScoreNumber")
	score_number.text = str(score)


func get_heart_icon():
	var icon = TextureRect.new()
	icon.set_texture(texture)
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	return icon


func set_live_icons(lives):
	var live_icons = get_node("MenuContainer/HealthContainer/MarginContainer/LiveIconsContainer")
	var num_live_icons = live_icons.get_child_count()
	if lives > num_live_icons:
		for i in range(lives - num_live_icons):
			live_icons.add_child(get_heart_icon())
	if lives < num_live_icons:
		for i in range(num_live_icons - lives):
			live_icons.get_child(i).queue_free()
