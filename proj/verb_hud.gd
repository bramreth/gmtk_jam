extends CenterContainer

onready var texter = get_node("LineEdit")
var active = false

func _ready():
	activate_texter(active)

func _input(event):
	if Input.get_action_strength("ui_accept") and not active:
		activate_texter(true)
		get_tree().set_input_as_handled()

func _on_LineEdit_text_entered(new_text: String):
	# sanitise the text before parsing
	var s_text = new_text.strip_edges()
	s_text = s_text.to_lower()
	if s_text.empty():
		activate_texter(false)
	else:
		parse_text(s_text)
	texter.text = ""

func activate_texter(on):
	visible = on
	texter.editable = on
	active = on
	if on: texter.grab_focus()
	else: texter.release_focus()

# similarity

func _on_LineEdit_text_changed(new_text: String):
	if new_text.ends_with(" ") and new_text.length():
		_on_LineEdit_text_entered(new_text)

func parse_text(text_in: String):
	
	var valid = false
	var keywords = ['dance', 'open', 'attack', 'seduce', 'help']
	var top_word = ["", 0.5]
	for k in keywords:
		var sim = text_in.similarity(k)
		if sim > top_word[1]:
			top_word = [k, sim]
	print(top_word)
	if top_word[0]:
		valid = true
	print(valid)
	if valid: activate_texter(false)
