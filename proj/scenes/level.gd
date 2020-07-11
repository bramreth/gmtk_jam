extends Node2D
export(int) var floor_num

"""
this is the base scene for levels it will contain goal logic, the tile map etc
"""
func _ready():
	EventBus.emit_signal("start_dungeon_master_dialog", "floor"+ str(floor_num))
