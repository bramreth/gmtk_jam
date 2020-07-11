extends Area2D

export (GameManager.stipulation) var stipulation = GameManager.stipulation.NONE

func _on_body_entered(body):
	if body.name == "player":
		_on_player_entered(body)
		_on_stipulation()

func _on_player_entered(player):
	pass

func _on_stipulation():
	GameManager.stipulation(stipulation)
	queue_free()
