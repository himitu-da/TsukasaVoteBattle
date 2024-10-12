# cylinder.gd
extends Area2D

# 発射速度をエクスポート変数として設定（エディターで調整可能）
@export var speed = 750

@export var min_x = -20.0
@export var max_x = 1300.0
@export var min_y = -20.0
@export var max_y = 740.0

var direction = Vector2(1, 0)


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	# GameManager にアクセスする関数

func get_game_manager():
	return get_node("/root/MainGameScene/GameManager")

func _process(delta: float):
	position += direction * speed * delta
	
	if is_off_screen():
		queue_free()

func is_off_screen() -> bool:
	# X軸の範囲内に位置を制限
	if position.x < min_x:
		position.x = min_x
		return true
	elif position.x > max_x:
		position.x = max_x
		return true

	# Y軸の範囲内に位置を制限
	if position.y < min_y:
		position.y = min_y
		return true
	elif position.y > max_y:
		position.y = max_y
		return true
	return false

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		# 敵にダメージを与える処理
		var game_manager = get_game_manager()
		if game_manager:
			game_manager.add_votes(1)
		# 弾を削除
		queue_free()
