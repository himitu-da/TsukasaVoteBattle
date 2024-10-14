extends CharacterBody2D

# 揺れの幅（振幅）
@export var float_amplitude = 10.0
# 揺れの速さ（周波数）
@export var float_speed = 2.0

# 初期のY位置を記録する変数
var initial_y_position = 0.0
# 経過時間
var time_passed = 0.0

func _ready():
	# 初期のY位置を記録しておく
	initial_y_position = position.y

func _process(delta):
	# 経過時間を加算
	time_passed += delta
	
	# 上下に浮かせる動作（サイン波を使用）
	position.y = initial_y_position + sin(time_passed * float_speed) * float_amplitude
