extends Button


func _on_play_button_pressed():
	print("Play button pressed")  # ボタンが押されたか確認するため
	get_tree().change_scene_to_file("res://startgamescene.tscn")
