extends Control

onready var image = $image

func _ready():
	visible = false
	EventBus.connect("show_material", self, "_show_material")
	pass 


func _input(event):
	if visible and Input.get_action_strength("ui_cancel"):
		_remove_material()
		
func _show_material(id):
	image.texture = load("res://art_assets/reading_material/" + str(id) + ".png")
	visible = true
	pass

func _remove_material():
	visible = false
	image.texture = null
