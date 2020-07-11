extends Node2D
export(int) var floor_num

onready var stairs_down = $stairs_down
onready var player = $player
var cam_list = []
"""
this is the base scene for levels it will contain goal logic, the tile map etc
"""
func _ready():
	EventBus.emit_signal("start_dungeon_master_dialog", "floor"+ str(floor_num))
	player.set_spawn_point(stairs_down.position - Vector2(64, 64))
	cam_list = get_tree().get_nodes_in_group("cam_target")
	$Node2D.target = $camera_spots/Position2D
	$Node2D.zoom = $camera_spots/Position2D.zoom
	$Node2D.position = $camera_spots/Position2D.position


func _on_player_moved(pos: Vector2):
	var closest = [$Node2D.target, INF]
	for cam in cam_list:
		var d = pos.distance_to(cam.position)
		if d < closest[1]:
			closest = [cam, d]
	$Node2D.target = closest[0]
