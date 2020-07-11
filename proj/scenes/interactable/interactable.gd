extends StaticBody2D

export (int) var id = 0

onready var collision = $collision
onready var sprite = $collision/sprite
var is_interactible = true

func interact(verb):
	pass
