extends Node2D

func _ready():
	print("'E': finish dialogue")
	print("'ESC': quit")
	for c in $ButtonsContainer.get_children():
		c.queue_free()
	GameData.dict_dialogue = DialogueParser.loadDB("res://Assets/dialogue.txt", "dialogue")
	for s in GameData.dict_dialogue:
		var button: Button = Button.new()
		button.text = s
		$ButtonsContainer.add_child(button)
		button.button_down.connect(on_pressed.bind(s))
		button.focus_entered.connect(on_focus_entered.bind(s))
		if (GameData.dict_dialogue[s].has("choices")):
			button.grab_focus()
			GameData.dialogue_id = s

func _process(_delta):
	pass

func _input(event):
	if (Input.is_action_just_pressed("interact")):
		if (GameData.flag_displaying_dialogue):
			SignalController.emit_signal("finish_dialogue")
		elif (GameData.flag_waiting_dialogue_prompt):
			print("choice made! ", GameData.dialogue_choice_id)
			SignalController.emit_signal("close_dialogue")
		elif (GameData.flag_waiting_dialogue_next):
			SignalController.emit_signal("close_dialogue")
		else:
			on_pressed(GameData.dialogue_id)
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
			
func on_focus_entered(id: String):
	GameData.dialogue_id = id

func on_pressed(id: String):
	if (GameData.flag_waiting_dialogue_prompt): return
	print(id, " was pressed")
	for key in GameData.dict_dialogue[id]:
		print(" ", key, " -> ", GameData.dict_dialogue[id][key])
	SignalController.emit_signal("display_dialogue", id)
