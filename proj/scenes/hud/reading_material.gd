extends Control

onready var image = $image
onready var books = $books
onready var hint = $hint
onready var hint_label = $hint/Label
var view_count = 0

var current_book = ""
var book_data = {
	"book_0": {
		"hint": "   Use comands you find along\n   the trial to aid your escape",
		"counter": 0
	},
	"book_1": {
		"hint": "",
		"counter": 0
	},
}

func _ready():
	visible = false
	EventBus.connect("show_material", self, "_show")
	pass 

func _input(event):
	if visible and (Input.get_action_strength("ui_cancel") or Input.get_action_strength("ui_accept")):
		_hide()
		
func _show(id):
	current_book = "book_" + str(id)
	for book in books.get_children():
		if book.name == current_book:
			book.visible = true
			var hint_text = book_data[current_book]["hint"]
			print(hint_text, current_book)
			if !hint_text.empty():
				hint_label.text = hint_text
				hint.visible = true
				$animation_player.play("show_hint")
			GameManager.hud_active = true
			visible = true

func _hide():
	for book in books.get_children():
		book.visible = false
	hint.visible = false
	visible = false
	GameManager.hud_active = false
	Dialog.start_by_name(current_book +"_"+ str((book_data[current_book]["counter"]  % 3)))
	book_data[current_book]["counter"] += 1
