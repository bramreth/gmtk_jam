extends StaticBody2D

export (int) var id = 0

onready var collision = $collision
onready var sprite = $collision/sprite

func _ready():
	EventBus.connect("unlock_door", self, "_unlock")
	
func _unlock(id):
	if self.id == id:	
		collision.set_disabled(true)
		sprite.color =  Color( 1, 1, 255, 1 )
