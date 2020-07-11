extends Node

enum Sequence {
	floor1,
	floor2,
	floor3,
	DoorIsLocked,
	Help,
	dance
}

func start_by_name(name):
	for value in Dialog.Sequence.values():
		var key = Dialog.Sequence.keys()[value]
		if key == name:
			start(value)
			return
			
func start(sequence):
	EventBus.emit_signal("start_dungeon_master_dialog", sequence)
