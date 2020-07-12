extends "res://scenes/action_tiles/action_tile.gd"


export (Deaths.Type) var death_type = Deaths.Type.Larva

func _ready():
	sprite.animation = Deaths.Type.keys()[death_type]

func _on_player_entered(player):
		sprite.visible = true
		player.die(death_type)
