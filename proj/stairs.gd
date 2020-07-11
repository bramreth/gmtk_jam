extends Area2D

signal travel(up)
export var up = false

func _ready():
	self.connect("travel", GameManager, "change_floor")


func _on_stairs_body_entered(body):
	if body.name == "player":
		emit_signal("travel", up)
