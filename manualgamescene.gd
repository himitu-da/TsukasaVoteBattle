extends Control

func _ready():
	GameData.is_game_started = true

func _process(delta):
	if Input.is_action_pressed("ui_top"):
		get_tree().change_scene_to_file("res://startgamescene.tscn")
