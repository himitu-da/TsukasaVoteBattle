extends Control

func _process(delta):
	if Input.is_action_pressed("ui_start"):
		get_tree().change_scene_to_file("res://maingamescene.tscn")
	if Input.is_action_pressed("ui_manual"):
		get_tree().change_scene_to_file("res://manualgamescene.tscn")
