extends Control

onready var texter = get_node("LineEdit")
var active = false
var keywords = Verbs.get_list()
var known_k = [Verbs.OPEN]
var w_index = 0

func _ready():
	activate_texter(active)

func _input(event):
	if GameManager.hud_active: return
	if not active:
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
			activate_texter(true)
		elif Input.is_action_just_pressed("ui_accept"):
			activate_texter(true)
			get_tree().set_input_as_handled()
	if active:
		if Input.is_action_just_pressed("ui_up"):
			w_index = fposmod(w_index + 1, known_k.size())
			texter.text = known_k[w_index]
		if Input.is_action_just_pressed("ui_down"):
			w_index = fposmod(w_index - 1, known_k.size())
			texter.text = known_k[w_index]
		if Input.is_action_just_pressed("ui_cancel"):
			activate_texter(false)
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
	elif new_text == "ww" or new_text == "aa" or new_text == "ss" or new_text == "dd":
		_on_LineEdit_text_entered("")

func parse_text(text_in: String):
	var valid = false
	var top_word = ["", 0.5]
	for k in keywords:
		var sim = text_in.similarity(k)
		if sim > top_word[1]:
			top_word = [k, sim]
	print(top_word)
	if top_word[0]:
		valid = true
		var action = top_word[0]
		if !known_k.has(action) && keywords.has(action):
			known_k.push_back(action)
		match action:
			Verbs.HELP:
				Dialog.start(Dialog.Sequence.Help)
			Verbs.DANCE:
				GameManager.player.dance()
				EventBus.emit_signal("player_danced")
			_:
				if GameManager.player.active_interactible:
					GameManager.player.active_interactible.interact(action)
	if valid: activate_texter(false)
