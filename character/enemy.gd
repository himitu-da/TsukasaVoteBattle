extends CharacterBody2D

# プレイヤーのノードパス
@export var player: NodePath
@export var bullet: PackedScene
var v = 1
var bullet_direction = 0

var delta_direction = 0
var delta_d = 1

func _process(delta):	
	fire_bullet_straight(bullet_direction)
	
	if delta_direction > 1:
		delta_d = -1
	if delta_direction < -1:
		delta_d = 1
	
	delta_direction += delta_d * 0.01
	bullet_direction += delta_direction
	
	if self.position.y > 600:
		v = -1
	elif self.position.y < 120:
		v = 1

func fire_bullet_straight(bullet_direction: float):
	var b = bullet.instantiate()
	b.direction = b.direction.rotated(bullet_direction / PI)
	b.position = self.position
	get_tree().root.add_child(b)
