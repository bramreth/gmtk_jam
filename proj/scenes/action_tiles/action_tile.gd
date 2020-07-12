extends Area2D

export (GameManager.stipulation) var stipulation = GameManager.stipulation.NONE

onready var sprite = $collision/sprite
onready var audio_player = $audio_player

func _on_body_entered(body):
	if body.name == "player":
		_on_player_entered(body)
		_on_stipulation()

func _on_player_entered(player):
	pass

func _on_stipulation():
	GameManager.stipulation(stipulation)

func _play_sound(sound):
	audio_player.stop()
	audio_player.stream = load("res://sounds/" + sound)
	audio_player.play()
