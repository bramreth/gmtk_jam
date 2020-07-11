extends Node

enum Sequence {
	floor1,
	floor2,
	floor3,
	DoorIsLocked,
	Help
}

func start(sequence):
	EventBus.emit_signal("start_dungeon_master_dialog", Dialog.Sequence.keys()[sequence])
