extends "res://scenes/interactable/interactable.gd"
class_name interactible
export(bool) var locked = false

func _ready():
	EventBus.connect("unlock_door", self, "_unlock_and_open")
	EventBus.connect("lock_door", self, "_lock_and_close")
	
func interact(verb):
		if verb == Verbs.OPEN:
			_open()
		if verb == Verbs.CLOSE:
			print("close")
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
		$LightOccluder2D.set_occluder_light_mask(0) 
		sprite.color = Color(1, 255, 1)
		_play_sound("sfx/open.wav")
	else:
		Dialog.start(Dialog.Sequence.DoorIsLocked)

func _close():
	collision.set_deferred("disabled", false)
	sprite.color = Color(255, 1, 1)
	$LightOccluder2D.set_occluder_light_mask(1)
	# todo $LightOccluder2D un free queue?
