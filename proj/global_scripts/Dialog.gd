extends Node

enum Sequence {
	floor_1,
	floor_2,
	floor_3,
	book_0_0,
	book_0_1,
	book_0_2,
	DoorIsLocked,
	BadWalking,
	Help,
	dance,
	DoorIsLockedDoADance,
	win,
	final,
	fast
}

func start_by_name(name):
	print(name)
	for value in Dialog.Sequence.values():
		var key = Dialog.Sequence.keys()[value]
		if key == name:
			start(value)
			return
			
func start(sequence):
	EventBus.emit_signal("start_dungeon_master_dialog", sequence)
