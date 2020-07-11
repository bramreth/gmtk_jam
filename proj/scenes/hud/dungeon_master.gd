extends VBoxContainer

onready var sound_player = $sound_player
onready var dialog_container = $dialog
onready var dialog = $dialog/text
onready var animation_player = $animation_player

onready var DEFAULT_TEXT_SPEED = 0.07
onready var current_text_speed = DEFAULT_TEXT_SPEED

var dialog_list
var dialog_index = 0
var dispatching_text = false
var dialog_type = null


func _ready():
	EventBus.connect("start_dungeon_master_dialog", self, "_start_dialog")

func _input(event):
	if GameManager.in_dialog and Input.get_action_strength("ui_accept"):
		if dispatching_text:
			current_text_speed /= 2
		else:
			_next_dialog()
	
func _start_dialog(name, type):
	dialog_type = type
	if GameManager.in_dialog: return
	dialog_list = GameManager.get_dialog(name)
	dialog_index
	_next_dialog()
	GameManager.in_dialog = true
	animation_player.play("appear")

func _next_dialog():	
	dialog.text = ""
	current_text_speed = DEFAULT_TEXT_SPEED
	if dialog_list.size() > dialog_index:
		var speech = dialog_list[dialog_index]
		var text = speech["text"]
		var sound = speech["sound"]
		print(text, sound)
		if !sound.empty():
			sound_player.stop()
			sound_player.stream = load("res://sounds/" + sound)
			sound_player.play()
		if !text.empty():
			dispatching_text = true
			dialog_container.visible = true
			while text != "":
				yield(get_tree().create_timer(current_text_speed), "timeout")
				dialog.text += text.left(1)
				text = text.right(1)
			dispatching_text = false
		dialog_index += 1 
	else:
		_hide()
		
func _hide():
	match Dialog.Sequence.keys()[dialog_type]:
		"dance":
			GameManager.player.end_dance()
		_:
			pass
	dialog_list = null	
	dialog_index = 0
	GameManager.in_dialog = false
	dialog_container.visible = false
	animation_player.play_backwards("appear")
	
