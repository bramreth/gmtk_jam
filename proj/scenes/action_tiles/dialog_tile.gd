extends "res://scenes/action_tiles/action_tile.gd"

export (Dialog.Sequence) var dialog_sequence

func _on_player_entered(player):
	EventBus.emit_signal("start_dungeon_master_dialog", Dialog.Sequence.keys()[dialog_sequence])
