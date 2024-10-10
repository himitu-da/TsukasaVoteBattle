extends CharacterBody2D

# 敵キャラクターの移動速度
@export var speed = 100
# 移動方向 (1: 右, -1: 左)
var direction = 1

# 移動範囲の制限 (左右にパトロールする範囲)
@export var patrol_distance = 200
var start_position = Vector2.ZERO

func _ready():
	# 初期位置を記録
	start_position = position

func _process(delta):
	patrol(delta)

# 左右にパトロール動作を実装
func patrol(delta):
	# 移動
	position.x += direction * speed * delta

	# 一定距離移動したら方向を反転
	if abs(position.x - start_position.x) > patrol_distance:
		direction *= -1
