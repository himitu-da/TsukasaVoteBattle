extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", Callable(self, "_on_something_entered"))

func _process(delta):
	self.position -= Vector2(3, 0)
	
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		queue_free()

func _on_something_entered(body):
	if body.name == "player":
		queue_free()
