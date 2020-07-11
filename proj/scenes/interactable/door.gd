extends "res://scenes/interactable/interactable.gd"
class_name interactible
export(bool) var locked = false
export(bool) var o = false

func _ready():
	EventBus.connect("unlock_door", self, "_unlock_and_open")
	EventBus.connect("lock_door", self, "_lock_and_close")
	
func interact(verb):
		if verb == Verbs.OPEN:
			_open()
		if verb == Verbs.CLOSE:
			_close()
	
func _unlock_and_open(id):
	if self.id == id:	
		locked = false
		_open()

func _lock_and_close(id):
	if self.id == id:	
		locked = true
		_close()

func _open():
	if !locked:
		collision.set_deferred("disabled", true)
		$LightOccluder2D.queue_free()
		sprite.color = Color(1, 255, 1)
	else:
		Dialog.start(Dialog.Sequence.DoorIsLocked)

func _close():
	collision.set_deferred("disabled", false)
	collision.set_deferred("disabled", false)
	sprite.color = Color(255, 1, 1)
	# todo $LightOccluder2D un free queue?
