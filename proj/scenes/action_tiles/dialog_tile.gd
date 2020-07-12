extends "res://scenes/action_tiles/action_tile.gd"

export (Dialog.Sequence) var dialog_sequence

func _ready():
	sprite.visible = false
	
func _on_player_entered(player):
	Dialog.start(dialog_sequence)

func _on_stipulation():
	._on_stipulation()
	queue_free()
