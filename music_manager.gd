extends Node

var before_music_index = 5

@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

const MUSIC6_PATH = "res://music/1_03_haruirokomichi_154.ogg"
const MUSIC5_PATH = "res://music/2_10_back_door_all_169.ogg"
const MUSIC4_PATH = "res://music/3_midnight_spellcard_160.ogg"
const MUSIC3_PATH = "res://music/4_04_hooduki_140.ogg"
const MUSIC2_PATH = "res://music/5_02_koiiro_fms_167.ogg"
const MUSIC1_PATH = "res://music/6_01_shoujo_kisoukyoku_171.ogg"

func _ready():
	music_player.stream = load(MUSIC6_PATH)
	music_player.play()

func _process(delta):
	var now_music_index = (GameData.rank - 1) / 10
	if before_music_index > now_music_index && before_music_index != 6:
		match now_music_index:
			0:
				music_player.stream = load(MUSIC1_PATH)
				music_player.play()
			1:
				music_player.stream = load(MUSIC2_PATH)
				music_player.play()
			2:
				music_player.stream = load(MUSIC3_PATH)
				music_player.play()
			3:
				music_player.stream = load(MUSIC4_PATH)
				music_player.play()
			4:
				music_player.stream = load(MUSIC5_PATH)
				music_player.play()
			5:
				music_player.stream = load(MUSIC6_PATH)
				music_player.play()
	before_music_index = now_music_index
