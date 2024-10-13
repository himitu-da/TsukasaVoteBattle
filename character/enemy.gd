extends CharacterBody2D

# プレイヤーのノードパス
@export var player: NodePath
@export var bullet: PackedScene
var v = 1
var bullet_direction = 0

var delta_direction = 0
var delta_d = 1

# 振幅と速さを変えられるように変数を作成
@export var float_amplitude = 150.0  # 上下の移動幅
@export var float_speed = 1.0  # 上下移動の速さ

# 初期のY座標を記録するための変数
var initial_y_position = 0.0
var time_passed = 0.0  # 経過時間

func _ready():
	initial_y_position = position.y

func _process(delta):
	fire_bullet_straight(bullet_direction)
	time_passed += delta
	
	if delta_direction > 1:
		delta_d = -1
	if delta_direction < -1:
		delta_d = 1
	
	delta_direction += delta_d * 0.01
	bullet_direction += delta_direction
	
	if self.position.y > 600:
		v = -1
	elif self.position.y < 120:
		v = 1
	
	time_passed += delta
	position.y = initial_y_position + sin(time_passed * float_speed) * float_amplitude

func fire_bullet_straight(b_direction):
	var b = bullet.instantiate()
	b.direction = b.direction.rotated(b_direction / PI)
	b.position = self.position
	get_tree().root.add_child(b)
