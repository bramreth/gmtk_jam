extends "res://scenes/interactable/interactable.gd"

export(bool) var locked = false

func _ready():
	EventBus.connect("unlock_door", self, "_unlock_and_open")
	
func _interact(verb):
		_open()
	
func _unlock_and_open(id):
	if self.id == id:	
		locked = false
		_open()

func _open():
	if !locked:
		collision.set_disabled(true)
		sprite.color = Color(1, 1, 255, 1)
