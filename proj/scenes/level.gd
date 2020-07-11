extends Node2D
export(int) var floor_num

onready var stairs_down = $stairs_down
onready var player = $player

"""
this is the base scene for levels it will contain goal logic, the tile map etc
"""
func _ready():
	EventBus.emit_signal("start_dungeon_master_dialog", "floor"+ str(floor_num))
	player.set_spawn_point(stairs_down.position - Vector2(64, 64))
