extends Area2D

# 弾の速度
@export var speed = 400

# 弾の移動方向
var direction = Vector2.ZERO

func _process(delta):
	# 弾を指定方向に移動させる
	position += direction * speed * delta

	# 画面外に出たら削除
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		queue_free()

# 弾の移動方向をセットする関数
func set_direction(new_direction):
	direction = new_direction.normalized()
