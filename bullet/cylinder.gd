# cylinder.gd
extends Area2D

# 発射速度をエクスポート変数として設定（エディターで調整可能）
@export var speed = 750

@export var min_x = -20.0
@export var max_x = 1300.0
@export var min_y = -20.0
@export var max_y = 740.0

var direction = Vector2(1, 0)
@export var hyou: PackedScene
@export var big_hyou: PackedScene

var rng = RandomNumberGenerator.new()

func _ready():
	connect("area_entered", Callable(self, "_on_body_entered"))
	GameData.connect("reset_signal", Callable(self, "_on_reset"))

func _on_reset():
	queue_free()

func _process(delta: float):
	position += direction * speed * delta
	
	if is_off_screen():
		print("Delete Cylinder")
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
		var game_manager = get_node("/root/MainGameScene/GameManager")
		if game_manager:
			game_manager.add_votes(GameData.power - 1)
		
		var p
		var t = game_manager.elapsed_time
		if t < 50:
			p = 1
		else:
			p = 1.5 - t / 100.0
		
		if GameData.get_random_true(p):
			var h1 = hyou.instantiate()
			h1.position = self.position + Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
			call_deferred("add_hyou_to_scene", h1)
		else:
			var h1 = big_hyou.instantiate()
			h1.position = self.position + Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
			call_deferred("add_hyou_to_scene", h1)
		queue_free()
		# 弾を削除

func add_hyou_to_scene(hyou_instance):
	get_tree().root.add_child(hyou_instance)
