extends Area2D

# 弾の速度
@export var speed = 350

# 弾の移動方向
var direction = Vector2(-1, 0)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("area_entered", Callable(self, "_on_area_entered"))
	GameData.connect("finish_signal", Callable(self, "_on_finish"))

func _process(delta):
	# 弾を指定方向に移動させる
	position += direction * speed * delta
	rotation = direction.angle()
	
	# 画面外に出たら削除
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		queue_free()

# 弾の移動方向をセットする関数
func set_direction(new_direction):
	direction = new_direction.normalized()

func _on_body_entered(body):
	if body.name == "player":
		queue_free()

func _on_area_entered(body):
	if body.is_in_group("bomb_aura"):
		queue_free()
		
func _on_finish():
	queue_free()
