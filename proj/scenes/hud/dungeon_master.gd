extends VBoxContainer

var image_res_path = "res://art_assets/"

onready var sound_player = $sound_player
onready var dialog_container = $dialog
onready var dialog = $dialog/text
onready var animation_player = $animation_player

onready var dm_image = $Control/TextureRect

onready var DEFAULT_TEXT_SPEED = 0.07
onready var current_text_speed = DEFAULT_TEXT_SPEED

var dialog_list
var dialog_index = 0
var dispatching_text = false
var dialog_sequence = null


func _ready():
	EventBus.connect("start_dungeon_master_dialog", self, "_start_dialog")

func _input(event):
	if dialog_list != null:
		if dialog_list.size() > dialog_index:
			if Input.get_action_strength("ui_accept"):
				if dispatching_text:
					current_text_speed /= 2
				else:
					_next_dialog()
		else:
			print("5")
			_hide()
	
func _start_dialog(sequence):
	dialog_sequence = sequence
	if GameManager.hud_active: return
	dialog_list = GameManager.get_dialog(Dialog.Sequence.keys()[sequence])
	dialog_index
	GameManager.hud_active = true
	animation_player.play("appear")
	_next_dialog()
	
func _next_dialog():	
	dialog.text = ""
	current_text_speed = DEFAULT_TEXT_SPEED
	var speech = dialog_list[dialog_index]
	var text = speech["text"]
	var image = speech["image"]
	var sound = speech["sound"]
	print(text, image, sound)
	dm_image.texture = load(image_res_path + image) if !image.empty() else load(image_res_path + "dm1.png")
		
	if !sound.empty():
		sound_player.stop()
		sound_player.stream = load("res://sounds/" + sound)
		sound_player.play()
	if !text.empty():
		dialog_container.visible = true
		dispatching_text = true
		dialog_container.visible = true
		while text != "":
			yield(get_tree().create_timer(current_text_speed), "timeout")
			dialog.text += text.left(1)
			text = text.right(1)
		dispatching_text = false
	else :
		dialog_container.visible = false
	dialog_index += 1 
		
func _hide():
	match dialog_sequence:
		Dialog.Sequence.dance:
			GameManager.player.end_dance()
		Dialog.Sequence.win:
			get_tree().quit()
		_:
			pass
	dialog_list = null	
	dialog_index = 0
	GameManager.hud_active = false
	animation_player.play("disappear")
	
func _on_disapeared():
	dialog.text = ""
