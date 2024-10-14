extends CharacterBody2D

@export var cylinder: PackedScene
@export var bomb_aura: PackedScene

# 直近のショット
var last_time_shot = 0
# 直近のボム
var last_time_bomb = 5.0

# 通常の移動速度
@export var speed = 400
# 低速移動時の速度
@export var slow_speed = 150

# キャラクターの移動ベクトル
var movement_velocity = Vector2.ZERO

# 揺れの幅（振幅）と速さ（周波数）
@export var float_amplitude = 5.0
@export var float_speed = 2.0

# 初期のY位置を記録する変数
var initial_sprite_y_position = 0.0
# 経過時間
var time_passed = 0.0


# 移動できる範囲を定義（例: 画面の左上 (100, 100) から右下 (700, 500) の範囲）
@export var min_x = 20.0
@export var max_x = 1260.0
@export var min_y = 20.0
@export var max_y = 700.0

# 赤い円の表示状態を管理するフラグ
var red_circle_visible = false

func _ready():
	# スプライトの初期Y位置を記録
	$Area2D.connect("area_entered", Callable(self, "_on_something_entered"))
	initial_sprite_y_position = $Sprite2D.position.y
	# 赤い円 (当たり判定可視化) の初期設定: 非表示
	$RedCircle.visible = false

func _process(delta):
	if GameData.is_game_started:
		# 時間追加
		last_time_shot += delta
		last_time_bomb += delta
		# 入力を受け取ってプレイヤーの動きを更新
		handle_input()
		
		# 速度を適用して移動
		velocity = movement_velocity
		move_and_slide()
		
		# 移動範囲を制限する
		limit_movement()

	# スプライトのみ揺らす（当たり判定は動かさない）
	float_sprite(delta)

	# 当たり判定の表示を更新
	update_collision_visibility()

# キーボード入力を処理
func handle_input():
	movement_velocity = Vector2.ZERO  # 毎フレームリセットして新しい入力を反映

	if Input.is_action_pressed("ui_right"):
		movement_velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		movement_velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		movement_velocity.y -= 1
		
	if Input.is_action_pressed("ui_shot") && last_time_shot >= 0.1:
		var c1 = cylinder.instantiate()
		var c2 = cylinder.instantiate()
		c1.position = self.position + Vector2(20, 10)
		c2.position = self.position + Vector2(20, -10)
		get_tree().root.add_child(c1)
		get_tree().root.add_child(c2)
		$CylinderSE.play()
		last_time_shot = 0
	
	# ボム
	if Input.is_action_pressed("ui_bomb") && last_time_bomb >= 5:
		var b1 = bomb_aura.instantiate()
		b1.position = self.position
		get_tree().root.add_child(b1)
		var game_manager = get_node("/root/MainGameScene/GameManager")
		if game_manager:
			game_manager.add_votes(-1 * GameData.get_hidan_dec())
		GameData.bomb += 1
		$BombSE.play()
		last_time_bomb = 0

	# 速度を決定（Shiftキーが押されている場合は低速移動）
	var current_speed = speed
	if Input.is_action_pressed("ui_shift"):
		current_speed = slow_speed

	# 入力ベクトルを正規化して速度を掛け算
	movement_velocity = movement_velocity.normalized() * current_speed

# 移動範囲を制限する関数
func limit_movement():
	# X軸の範囲内に位置を制限
	if position.x < min_x:
		position.x = min_x
	elif position.x > max_x:
		position.x = max_x

	# Y軸の範囲内に位置を制限
	if position.y < min_y:
		position.y = min_y
	elif position.y > max_y:
		position.y = max_y

# スプライトを上下に揺らす動作
func float_sprite(delta):
	# 経過時間を加算
	time_passed += delta
	# スプライトのY位置を揺らす（サイン波で上下動）
	$Sprite2D.position.y = initial_sprite_y_position + sin(time_passed * float_speed) * float_amplitude

# Shiftキーが押されている間は当たり判定を表示
func update_collision_visibility():
	# Shiftキーが押されている間、当たり判定の赤い円を表示
	if Input.is_action_pressed("ui_shift"):
		$RedCircle.visible = true
	else:
		$RedCircle.visible = false

func _on_something_entered(body):
	if body.is_in_group("danmaku"):
		var game_manager = get_node("/root/MainGameScene/GameManager")
		if game_manager:
			game_manager.change_time_limit(-5)
			game_manager.add_votes(-1 * GameData.get_hidan_dec())
		GameData.hidan += 1
		$HidanSe.play()
	if body.is_in_group("hyou"):
		var game_manager = get_node("/root/MainGameScene/GameManager")
		if game_manager:
			game_manager.add_votes(1)
		$HyouSE.play()
