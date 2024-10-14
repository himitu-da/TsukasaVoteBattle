extends Node

# 制限時間（秒）
@export var time_limit: float = 100.0  # 100秒に設定
var remaining_time: float

# UIラベルへの参照
@onready var timer_label: Label = $TimerLabel
@onready var score_label: Label = $ScoreLabel
@onready var rank_label: Label = $RankLabel  # 順位表示用のLabel


func _ready():
	remaining_time = time_limit
	GameData.reset()
	
	update_timer_label()
	update_score_label()

func _process(delta):
	if remaining_time > 0:
		remaining_time -= delta
		remaining_time = max(remaining_time, 0.0)  # 負の値にならないように
		
	if remaining_time <= 0.0:
		on_time_up()
		
	update_timer_label()

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

func on_time_up():
	get_tree().change_scene_to_file("res://resultgamescene.tscn")

func add_votes(amount: int):
	GameData.votes += amount
	update_score_label()

func change_time_limit(times: float):
	remaining_time += times
	update_timer_label()
