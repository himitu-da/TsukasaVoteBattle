extends CharacterBody2D

# 弾のシーン
@export var bullet_scene : PackedScene
# 弾の発射間隔
@export var fire_rate = 1.0
# 次の弾を発射するまでのカウントダウン
var fire_timer = 0.0

func _process(delta):
	# 弾発射のタイマーをカウントダウン
	fire_timer -= delta

	# タイマーがゼロになったら弾を発射
	if fire_timer <= 0:
		fire_bullet()
		fire_timer = fire_rate  # 次の弾の発射までの時間をリセット

# 弾を発射する関数
func fire_bullet():
	# 弾のインスタンスを生成
	var bullet = bullet_scene.instantiate()

	# 弾の発射位置（敵キャラクターの前方から発射する場合）
	bullet.position = position + Vector2(0, 20)

	# 弾の移動方向を設定（例：下方向に発射）
	bullet.set_direction(Vector2(0, 1))

	# 弾をシーンツリーに追加
	get_tree().root.add_child(bullet)
