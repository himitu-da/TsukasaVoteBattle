extends Node

# 制限時間（秒）
@export var time_limit: float = 100.0  # 100秒に設定
var remaining_time: float

# UIラベルへの参照
@onready var timer_label: Label = $ColorRect/TimerLabel
@onready var score_label: Label = $ColorRect2/ScoreLabel
@onready var rank_label: Label = $ColorRect3/RankLabel  # 順位表示用のLabel
@onready var hidan_label: Label = $ColorRect4/HidanLabel
@onready var bomb_label: Label = $ColorRect5/BombLabel
@onready var bomb_dec_label: Label = $ColorRect6/BombDecLabel
@onready var hidan_dec_label: Label = $ColorRect7/HidanDecLabel


func _ready():
	remaining_time = time_limit
	$StartLabel.modulate.a = 1
	GameData.reset()
	
	update_timer_label()
	update_score_label()
	update_hidan_label()
	update_bomb_label()
	update_dec_label()

func _process(delta):
	if GameData.is_game_started:
		if remaining_time > 0:
			remaining_time -= delta
			remaining_time = max(remaining_time, 0.0)  # 負の値にならないように
			
		if remaining_time <= 0.0:
			on_time_up()
			
		update_timer_label()
		update_hidan_label()
		update_bomb_label()
		update_dec_label()
	else:
		if Input.is_action_pressed("ui_gamestart"):
			GameData.is_game_started = true
			$StartLabel.modulate.a = 0

func update_timer_label():
	if remaining_time < 0:
		remaining_time = 0.0
	# 小数点以下2桁まで表示し、「秒」を追加
	timer_label.text = "%.2f" % remaining_time

func update_score_label():
	# スコアを「票数: XXX」に表示
	score_label.text = "%d" % GameData.votes
	
	# 順位を取得
	GameData.rank = GameData.get_rank(GameData.votes)
	rank_label.text = "%d" % GameData.rank

func update_hidan_label():
	hidan_label.text = "%d" % GameData.hidan

func update_bomb_label():
	bomb_label.text = "%d" % GameData.bomb

func update_dec_label():
	bomb_dec_label.text = "%d" % GameData.get_bomb_dec()
	hidan_dec_label.text = "%d" % GameData.get_hidan_dec()

func on_time_up():
	GameData.emit_finish_signal()
	get_tree().change_scene_to_file("res://resultgamescene.tscn")

func add_votes(amount: int):
	GameData.votes += amount
	if GameData.votes < 1553:
		GameData.votes = 1553
	update_score_label()

func change_time_limit(times: float):
	remaining_time += times
	update_timer_label()
