extends Control

onready var image = $image

func _ready():
	visible = false
	EventBus.connect("show_material", self, "_show")
	pass 

func _input(event):
	if visible and (Input.get_action_strength("ui_cancel") or Input.get_action_strength("ui_accept")):
		_hide()
		
func _show():
	$animation_player.play("show_hint")
	GameManager.hud_active = true
	visible = true

func _hide():
	GameManager.hud_active = false
	visible = false
