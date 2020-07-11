extends "res://scenes/interactable/interactable.gd"

func _interact(verb):
	EventBus.emit_signal("show_material", id)
