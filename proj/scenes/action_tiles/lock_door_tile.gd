extends "res://scenes/action_tiles/action_tile.gd"

export (int) var door_id = 0

func _ready():
	sprite.visible = false

func _on_player_entered(player):
	EventBus.emit_signal("lock_door", door_id)
	
