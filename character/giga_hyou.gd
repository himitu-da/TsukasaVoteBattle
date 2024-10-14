extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_something_entered"))
	GameData.connect("reset_signal", Callable(self, "_on_reset"))

func _on_reset():
	queue_free()

func _process(delta):
	self.position -= Vector2(5.5, 0)
	
	if is_off_screen():
		print("delete hyou")
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

func _on_something_entered(body):
	if body.name == "player":
		#var h1 = duplicate()
		#h1.position = GameData.get_spawn_position()
		#call_deferred("add_hyou_to_scene", h1)
		queue_free()

func add_hyou_to_scene(hyou_instance):
	get_tree().root.add_child(hyou_instance)
