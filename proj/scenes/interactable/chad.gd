extends "res://scenes/interactable/interactable.gd"

export(int) var type = 0

func _ready():
	match type:
		0:
			$collision/sprite.animation = "r"
		1:
			$collision/sprite.animation = "g"
		2: 
			$collision/sprite.animation = "b"

func interact(verb):
	if verb == Verbs.ATTACK:
		queue_free()
