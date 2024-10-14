extends CharacterBody2D

# プレイヤーのノードパス
@export var player: NodePath
@export var bullet: PackedScene
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
	if GameData.is_game_started:
		time_passed += delta
		
		if GameData.rank > 55:
			phase1()
		elif GameData.rank > 50:
			phase2()
		time_passed += delta
		position.y = initial_y_position + sin(time_passed * float_speed) * float_amplitude

func phase1():
	print(delta_direction)
	if delta_direction > 25:
		delta_d = -1.0
	if delta_direction < 15:
		delta_d = 1.0
	delta_direction += delta_d * 0.1
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction)

func phase2():
	if delta_direction > 10:
		delta_d = -1
	if delta_direction < 5:
		delta_d = 1
	delta_direction += delta_d * 0.05
	bullet_direction += delta_direction
	fire_bullet_straight(bullet_direction)

func fire_bullet_straight(b_direction):
	var b = bullet.instantiate()
	b.direction = b.direction.rotated(deg_to_rad(b_direction))
	b.position = self.position
	get_tree().root.add_child(b)
