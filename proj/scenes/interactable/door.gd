extends "res://scenes/interactable/interactable.gd"
class_name interactible
export(bool) var locked = false
var open = false

var dance_id = 420

func _ready():
	EventBus.connect("player_danced", self, "_on_player_danced")
	EventBus.connect("unlock_door", self, "_unlock_and_open")
	EventBus.connect("lock_door", self, "_lock_and_close")
	
func interact(verb):
		if verb == Verbs.OPEN:
			_open()
		if verb == Verbs.CLOSE:
			_close()
	
func _on_player_danced():
	if id == dance_id:
		Dialog.start(Dialog.Sequence.dance)
		_unlock_and_open(id)
	
func _unlock_and_open(id):
	if self.id == id:	
		locked = false
		_open()

func _lock_and_close(id):
	if self.id == id:	
		locked = true
		_close()

func _open():
	if !open:
		if !locked:
			collision.set_deferred("disabled", true)
			$LightOccluder2D.set_occluder_light_mask(0) 
			sprite.frame = 1
			_play_sound("sfx/open.wav")
			open = true
		else:
			if id == dance_id:
				Dialog.start(Dialog.Sequence.DoorIsLockedDoADance)
			else:
				Dialog.start(Dialog.Sequence.DoorIsLocked)
				

func _close():
	if open:
		collision.set_deferred("disabled", false)
		$LightOccluder2D.set_occluder_light_mask(1) 
		sprite.frame = 0
		_play_sound("sfx/close.wav")
		open = false
	# todo $LightOccluder2D un free queue?
