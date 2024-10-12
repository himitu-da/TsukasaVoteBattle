extends CharacterBody2D

# プレイヤーのノードパス
@export var player: NodePath
@export var bullet: PackedScene
var v = 1
var bullet_direction = 0

func _process(delta):	
	var b = bullet.instantiate()
	b.direction = b.direction.rotated(bullet_direction / PI)
	b.position = self.position
	get_tree().root.add_child(b)
	
	bullet_direction += 1
	
	if self.position.y > 600:
		v = -1
	elif self.position.y < 120:
		v = 1
