extends Node


var bg_player: AudioStreamPlayer
var pe_players: Array
var bge_players: Array

const intro_theme := preload("res://assets/sound/tracks/intro/ES_Absinthe-Minded.mp3")
const level_0_theme := preload("res://assets/sound/tracks/level0/ES_Loss and Love.mp3")
const game_over_theme := preload("res://assets/sound/effects/dead.mp3")
const collect_orbe_effect := preload("res://assets/sound/effects/collect_orbe.mp3")
const collect_flower_effect := preload("res://assets/sound/effects/collect_flower.mp3")
const collect_heart_effect := preload("res://assets/sound/effects/collect_heart.mp3")
const damage_effect := preload("res://assets/sound/effects/hit.mp3")
const jump_effect := preload("res://assets/sound/effects/whir.mp3")
const wind_blow_effect := preload("res://assets/sound/effects/blow.mp3")
const wind_storm_effect := preload("res://assets/sound/effects/wind_storm.mp3")
const bounce_effect := preload("res://assets/sound/effects/bounce.mp3")
const win_theme := preload("res://assets/sound/tracks/win_theme/ES_Where Do We Go.mp3")


func _ready():
	bg_player = AudioStreamPlayer.new()
	bge_players = [
		AudioStreamPlayer.new(),
		AudioStreamPlayer.new(),
	]
	add_child(bg_player)
	add_child(bge_players[0])
	add_child(bge_players[1])


func _process(_delta):
	pass


func set_pe_players(sound_players: Array):
	pe_players = sound_players


func play_bg_theme(theme: AudioStream):
	bg_player.stop()
	bg_player.set_stream(theme)
	bg_player.play()


func play_intro_theme():
	play_bg_theme(intro_theme)


func play_win_theme():
	play_bg_theme(win_theme)


func play_level_theme(level: int):
	match level:
		0:
			play_bg_theme(level_0_theme)
		_:
			pass


func play_game_over_theme():
	play_bg_theme(game_over_theme)


func play_pe_effect(effect: AudioStream, pool_id: int = 0):
	play_effect_from_pool(pe_players, effect, pool_id)


func play_bge_effect(effect: AudioStream, pool_id: int = 0):
	play_effect_from_pool(bge_players, effect, pool_id)


func play_background_effect(effect: String):
	match effect:
		"blow":
			play_bge_effect(wind_blow_effect)
		"storm":
			play_bge_effect(wind_storm_effect, 1)
		_:
			pass


func play_player_effect(effect: String):
	match effect:
		"collect_orbe":
			play_pe_effect(collect_orbe_effect)
		"collect_flower":
			play_pe_effect(collect_flower_effect)
		"collect_star":
			play_pe_effect(collect_flower_effect)
		"collect_heart":
			play_pe_effect(collect_heart_effect)
		"damage":
			play_pe_effect(damage_effect)
		"jump":
			play_pe_effect(jump_effect, 1)
		"bounce":
			play_pe_effect(bounce_effect)
		_:
			pass

func play_effect_from_pool(sound_players: Array, effect: AudioStream, pool_id: int):
	if sound_players == null:
		return
	if pool_id >= sound_players.size():
		return
	sound_players[pool_id].stop()
	sound_players[pool_id].set_stream(effect)
	sound_players[pool_id].play()
