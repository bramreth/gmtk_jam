extends "res://scenes/action_tiles/action_tile.gd"

export(int) var tile_action = 0

export (Dialog.Sequence) var dialog_sequence

func _on_player_entered(player):
	print(player.name)
	EventBus.emit_signal("start_dungeon_master_dialog", Dialog.Sequence.keys()[dialog_sequence])
	match tile_action:
		1:
			GameManager.stipulation(GameManager.stipulation.FAST)
		_:
			pass
	queue_free()
