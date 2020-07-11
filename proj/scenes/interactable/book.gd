extends "res://scenes/interactable/interactable.gd"

func _interact(verb):
	EventBus.read_book(id)
