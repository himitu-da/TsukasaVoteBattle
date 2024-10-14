extends Area2D

var area_scale = 0.0
var tween = create_tween()
var tween2 = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.scale = Vector2(1, 1)
	$CollisionShape2D.scale = Vector2(1, 1)
	tween.tween_property($Sprite2D, "scale", Vector2(3.0, 3.0), 1)
	tween2.tween_property($CollisionShape2D, "scale", Vector2(3.0, 3.0), 1.5)
	tween.tween_property($Sprite2D, "modulate:a", 0, 1.5)
	tween.tween_callback(queue_free)

'''
func bigger():
	for a in range(45):
		await get_tree().create_timer(1.0 / 30.0).timeout
		var t = (a + 1.0) / 45.0
		var t2 = -2.0 * (t - 1.0) ** 2 + 3.0
		$Sprite2D.scale = Vector2(t2, t2)
		$CollisionShape2D.scale = Vector2(t2, t2)

func less_modulate():
	for a in range(45):
		await get_tree().create_timer(1.0 / 30.0).timeout
		self.modulate.a -= 1.0 / 45.0
'''
