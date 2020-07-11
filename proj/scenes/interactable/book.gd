extends "res://scenes/interactable/interactable.gd"

func _interact(verb):
	EventBus.show_material(id)
