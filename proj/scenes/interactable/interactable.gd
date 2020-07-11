extends StaticBody2D

export (int) var id = 0

onready var collision = $collision
onready var sprite = $collision/sprite
onready var audio_player = $audio_player

var is_interactible = true

func interact(verb):
	pass

func _play_sound(sound):
	audio_player.stop()
	audio_player.stream = load("res://sounds/" + sound)
	audio_player.play()
