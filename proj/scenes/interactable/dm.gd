extends "res://scenes/interactable/interactable.gd"


func interact(verb):
	if verb == Verbs.COMPLIMENT:
		Dialog.start_by_name("win")
