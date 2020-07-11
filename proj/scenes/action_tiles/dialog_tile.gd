extends "res://scenes/action_tiles/action_tile.gd"

export (Dialog.Sequence) var dialog_sequence

func _on_player_entered(player):
	Dialog.start(dialog_sequence)
