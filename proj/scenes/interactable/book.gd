extends "res://scenes/interactable/interactable.gd"

func interact(verb):
	if verb == Verbs.READ or verb == Verbs.OPEN:
		EventBus.emit_signal("show_material")
