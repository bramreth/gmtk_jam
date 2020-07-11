extends Node

var level = 1

var dialog_path:String = "res://data/dialog.cfg"
var dialog_json
var in_dialog = false

func _ready() -> void:
	var dialog_data = File.new()
	if dialog_data.file_exists(dialog_path): 
		dialog_data.open(dialog_path, dialog_data.READ)
		dialog_json = JSON.parse(dialog_data.get_as_text()).result
		dialog_data.close()

func get_dialog(name):
	 return dialog_json[name]

func change_floor(up):
	if up:
		level += 1
		var next_scene_path = "res://scenes/level_"+str(level)+".tscn"
		get_tree().change_scene(next_scene_path)
