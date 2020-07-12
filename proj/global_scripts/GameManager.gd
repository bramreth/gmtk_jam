extends Node

var level = 1
enum stipulation{
	FAST,
	NONE
}
var dialog_path:String = "res://data/dialog.cfg"
var dialog_json
var hud_active = false
var player = null


onready var bg_music := AudioStreamPlayer.new()

func _ready() -> void:
	var dialog_data = File.new()
	if dialog_data.file_exists(dialog_path): 
		dialog_data.open(dialog_path, dialog_data.READ)
		dialog_json = JSON.parse(dialog_data.get_as_text()).result
		dialog_data.close()
	
	add_child(bg_music)
	bg_music.stream = load("res://sounds/bg2.wav")
	bg_music.autoplay = true
	bg_music.connect("finished", self, "_play_music")
	_play_music()
	
func _play_music():
	bg_music.play()

func get_dialog(name):
	 return dialog_json[name]

func change_floor(up):
	if up:
		level += 1
		var next_scene_path = "res://scenes/level_"+str(level)+".tscn"
		get_tree().change_scene(next_scene_path)

func stipulation(stip):
	player.current_stip = stip
