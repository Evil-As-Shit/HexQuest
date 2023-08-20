extends Node2D

func _ready():
	print("'L': load dialogue")

func _process(_delta):
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_L:
			for c in get_node("ButtonsContainer").get_children():
				c.queue_free()
			print("Loading dialogue...")
			var data = DialogueParser.loadDB("res://Assets/dialogue.txt", "dialogue")
			for s in data:
				print(s["id"])
				var button: Button = Button.new()
				button.text = s["id"]
				get_node("ButtonsContainer").add_child(button);
				for key in s:
					print(" ", key, " -> ", s[key])
