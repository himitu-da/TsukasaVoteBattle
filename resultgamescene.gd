extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Votes/VotesValue.text = str(GameData.votes) + " 票"
	$Rank/RankValue.text = str(GameData.rank) + " 位"

func _process(delta):
	pass
