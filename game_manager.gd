extends Node

# 制限時間（秒）
@export var time_limit: float = 100.0  # 100秒に設定
var remaining_time: float

# 順位基準リスト（降順）
var vote_thresholds = [
	21959,
	20249,
	17324,
	16273,
	14445,
	14437,
	13785,
	9921,
	9377,
	8159,
	7973,
	7417,
	7235,
	6762,
	6491,
	5996,
	5559,
	5302,
	5235,
	5207,
	5152,
	4914,
	4806,
	4288,
	4151,
	3716,
	3715,
	3695,
	3635,
	3519,
	3463,
	3372,
	3305,
	3220,
	3174,
	3144,
	3100,
	3012,
	3011,
	2967,
	2849,
	2803,
	2774,
	2731,
	2540,
	2528,
	2278,
	2220,
	2087,
	1926,
	1924,
	1898,
	1883,
	1776,
	1680,
	1667,
	1611,
	1602,
	1590,
	1568
]

# スコア（票数）
var votes: int = 1553

# UIラベルへの参照
@onready var timer_label: Label = $TimerLabel
@onready var score_label: Label = $ScoreLabel
@onready var rank_label: Label = $RankLabel  # 順位表示用のLabel

func _ready():
	remaining_time = time_limit
	
	update_timer_label()
	update_score_label()

func _process(delta):
	if remaining_time > 0:
		remaining_time -= delta
		remaining_time = max(remaining_time, 0.0)  # 負の値にならないように
		update_timer_label()

		if remaining_time == 0.0:
			on_time_up()

func update_timer_label():
	# 小数点以下2桁まで表示し、「秒」を追加
	timer_label.text = "%.2f" % remaining_time

func update_score_label():
	# スコアを「票数: XXX」に表示
	score_label.text = "%d" % votes
	
	# 順位を取得
	var rank = get_rank(votes)
	rank_label.text = "%d" % rank

func on_time_up():
	print("時間切れ！ゲームオーバー")
	# 例: ゲームオーバー画面に遷移する
	# get_tree().change_scene("res://path_to_game_over_scene.tscn")
	# スコアを表示するなどの処理を追加

func add_votes(amount: int):
	votes += amount
	update_score_label()

# 票数に基づいて順位を返す関数
func get_rank(current_votes: int) -> int:
	for i in range(vote_thresholds.size()):
		if current_votes >= vote_thresholds[i]:
			return i + 1
	return vote_thresholds.size() + 1  # リスト内にない場合
