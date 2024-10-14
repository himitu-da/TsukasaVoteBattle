extends Button


func _on_manual_button_pressed():
	get_tree().change_scene_to_file("res://manualgamescene.tscn")
