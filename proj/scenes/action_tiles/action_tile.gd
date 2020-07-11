extends Area2D

func _on_body_entered(body):
	if body.name == "player":
		_on_player_entered(body)

func _on_player_entered(player):
	pass
