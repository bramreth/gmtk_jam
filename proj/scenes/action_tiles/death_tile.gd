extends "res://scenes/action_tiles/action_tile.gd"


export (Deaths.Type) var death_type = Deaths.Type.Fire

func _on_player_entered(player):
		player.die(death_type)
