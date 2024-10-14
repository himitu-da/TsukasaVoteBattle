extends Area2D

@export var giga_hyou: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_something_entered"))
	GameData.connect("reset_signal", Callable(self, "_on_reset"))

func _on_reset():
	queue_free()

func _process(delta):
	self.position -= Vector2(4.5, 0)
	
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
		var h1 = duplicate()
		h1.position = GameData.get_spawn_position()
		call_deferred("add_hyou_to_scene", h1)
		var game_manager = get_node("/root/MainGameScene/GameManager")
		var p = max(game_manager.elapsed_time / 500.0 - 0.08, 0.06)
		if GameData.get_random_true(p):
			var h2 = giga_hyou.instantiate()
			h2.position = GameData.get_spawn_position()
			call_deferred("add_hyou_to_scene", h2)
		queue_free()

func add_hyou_to_scene(hyou_instance):
	get_tree().root.add_child(hyou_instance)
