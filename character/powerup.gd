extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	GameData.connect("reset_signal", Callable(self, "_on_reset"))

func _process(delta):
	self.position -= Vector2(2, 0)
	if is_off_screen():
		print("delete powerup")
		queue_free()

@export var min_x = -20.0
@export var max_x = 1300.0
@export var min_y = -20.0
@export var max_y = 740.0

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


func _on_reset():
	queue_free()

func _on_body_entered(body):
	if body.name == "player":
		queue_free()
