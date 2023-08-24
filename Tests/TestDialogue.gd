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
		get_node("ButtonsContainer").add_child(button);
		button.button_down.connect(on_pressed.bind(s))

func _process(_delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E:
			SignalController.emit_signal("finish_dialogue")
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()

func on_pressed(id: String):
	print(id, " was pressed")
	for key in GameData.dict_dialogue[id]:
		print(" ", key, " -> ", GameData.dict_dialogue[id][key])
	SignalController.emit_signal("display_dialogue", id)
