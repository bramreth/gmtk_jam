extends "res://scenes/interactable/interactable.gd"

func interact(verb):
	if verb == Verbs.READ or verb == Verbs.OPEN:
		_play_sound("sfx/page.wav")
		EventBus.emit_signal("show_material", id)
