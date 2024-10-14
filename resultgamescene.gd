extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Votes/VotesValue.text = str(GameData.votes) + " 票"
	$Rank/RankValue.text = str(GameData.rank) + " 位"
	$Hidan/HidanValue.text = str(GameData.hidan)
	$Bomb/BombValue.text = str(GameData.bomb)
	$Character/CharacterValue.text = str(GameData.get_character_by_rank(GameData.rank))

func _process(delta):
	if Input.is_action_pressed("ui_start"):
		get_tree().change_scene_to_file("res://maingamescene.tscn")
	if Input.is_action_pressed("ui_top"):
		get_tree().change_scene_to_file("res://startgamescene.tscn")
