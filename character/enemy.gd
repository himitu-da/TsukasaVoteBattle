extends CharacterBody2D

# プレイヤーのノードパス
@export var player: CharacterBody2D
@export var bullet: PackedScene

var bullet_direction = 0
var bullet_direction2 = 0
var delta_direction = 0
var delta_direction2 = 0
var delta_d = 1
var delta_d2 = 0
var is_start = true
var counter = 0

# 振幅と速さを変えられるように変数を作成
@export var float_amplitude = 150.0  # 上下の移動幅
@export var float_speed = 0.4  # 上下移動の速さ

# 初期のY座標を記録するための変数
var initial_y_position = 0.0
var time_passed = 0.0  # 経過時間

func _ready():
	initial_y_position = position.y

func _process(delta):
	if GameData.is_game_started:
		time_passed += delta
		
		if is_start:
			start_phase()
			is_start = false
		position.y = initial_y_position + sin(time_passed * float_speed) * float_amplitude

func start_phase():
	delta_direction = 10
	while GameData.rank > 50 && GameData.is_game_started:
		await phase1()
	while GameData.rank > 40 && GameData.is_game_started:
		await phase2()
	await get_tree().create_timer(1.0).timeout
	delta_direction = 20
	delta_direction2 = 19
	while GameData.rank > 30 && GameData.is_game_started:
		await phase3()
	while GameData.rank > 20 && GameData.is_game_started:
		await phase4()
	await get_tree().create_timer(1.0).timeout
	delta_direction = 10
	delta_direction2 = 10
	while GameData.rank > 10 && GameData.is_game_started:
		await phase5()
	delta_direction = 20
	delta_direction2 = 20
	while GameData.rank > 0 && GameData.is_game_started:
		await phase6()

func phase1():
	if delta_direction > 25:
		delta_d = -1
	if delta_direction < 20:
		delta_d = 1
	delta_direction += delta_d * 0.1
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction, 200)
	await wait_for_frames(5)
	
func phase2():
	if delta_direction > 18:
		delta_d = -1.0
	if delta_direction < 10:
		delta_d = 1.0
	delta_direction += delta_d * 0.1
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction)
	await wait_for_frames(3)

func phase3():
	if delta_direction > 25:
		delta_d = -1
	if delta_direction < 20:
		delta_d = 1
	delta_direction += delta_d * 0.02
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction)
	
	if delta_direction2 > 24:
		delta_d2 = -1
	if delta_direction2 < 19:
		delta_d2 = 1
	delta_direction2 += delta_d2 * 0.02
	bullet_direction2 = fmod(bullet_direction2, 360.0) - delta_direction2
	fire_bullet_straight(bullet_direction2)
	await wait_for_frames(4)

func phase4():
	if delta_direction > 15:
		delta_d = -1
	if delta_direction < 10:
		delta_d = 1
	delta_direction += delta_d * 0.14
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction)
	
	if delta_direction2 > 12:
		delta_d2 = -1
	if delta_direction2 < 7:
		delta_d2 = 1
	delta_direction2 += delta_d2 * 0.12
	bullet_direction2 = fmod(bullet_direction2, 360.0) - delta_direction2
	fire_bullet_straight(bullet_direction2, 325)
	await wait_for_frames(3)

func phase5():
	counter += 1
	if delta_direction > 9:
		delta_d = -1
	if delta_direction < 7:
		delta_d = 1
	delta_direction += delta_d * 0.02
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction, 200)
	if counter >= 20:
		counter = 0
		fire_bullet_to_player()
	await wait_for_frames(2)

func phase6():
	if delta_direction > 30:
		delta_d = -1
	if delta_direction < 20:
		delta_d = 1
	delta_direction += delta_d * 0.08
	bullet_direction = fmod(bullet_direction, 360.0) + delta_direction
	fire_bullet_straight(bullet_direction)
	fire_bullet_straight(bullet_direction + 4, 325)
	fire_bullet_straight(bullet_direction + 8, 350)
	if GameData.rank <= 5:
		fire_bullet_straight(bullet_direction + 12, 375)
	
	if delta_direction2 > 30:
		delta_d2 = -1
	if delta_direction2 < 20:
		delta_d2 = 1
	delta_direction2 += delta_d2 * 0.07
	bullet_direction2 = fmod(bullet_direction2, 360.0) - delta_direction2
	fire_bullet_straight(bullet_direction2 + 8)
	fire_bullet_straight(bullet_direction2 + 4, 325)
	fire_bullet_straight(bullet_direction2, 350)
	if GameData.rank <= 5:
		fire_bullet_straight(bullet_direction - 4, 375)
	if counter >= 10:
		counter = 0
		fire_bullet_to_player()
	await wait_for_frames(5)

func fire_bullet_straight(b_direction, speed = 300):
	var b = bullet.instantiate()
	b.direction = b.direction.rotated(deg_to_rad(b_direction))
	b.position = self.position
	b.speed = speed
	if is_instance_valid(get_tree()):
		get_tree().root.add_child(b)

func fire_bullet_to_player():
	var b = bullet.instantiate()
	b.position = self.position
	var direction = (player.position - self.position).normalized()
	b.direction = direction
	if is_instance_valid(get_tree()):
		get_tree().root.add_child(b)

func wait_for_frames(frame_count: int) -> void:
	for i in range(frame_count):
		if is_instance_valid(get_tree()):
			await get_tree().process_frame  # 次のフレームまで待つ
