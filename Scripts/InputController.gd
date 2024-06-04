extends Node

func _process(delta):
	GameData.move_input_vector = Vector2.ZERO
	if GameData.is_using_phone: return
	if GameData.is_in_dialogue: return
	GameData.move_input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).normalized()

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		if GameData.is_using_phone:
			match event.keycode:
				KEY_E: SignalController.emit_signal("phone_interacted")
				KEY_Q: SignalController.emit_signal("toggle_phone")
		elif GameData.flag_displaying_dialogue:
			if event.keycode == KEY_E: DialogueController.finish()
		elif GameData.flag_waiting_dialogue_prompt:
			if event.keycode == KEY_E: DialogueController.choose()
		elif GameData.flag_waiting_dialogue_next:
			if event.keycode == KEY_E: DialogueController.next()
		else:
			match event.keycode:
				KEY_E: SignalController.emit_signal("interaction_check")
				KEY_Q: SignalController.emit_signal("toggle_phone")
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
#		#Pressing E While Not On Phone (object interaction)
#		if event.keycode == KEY_E and !GameData.is_using_phone:
#			SignalController.emit_signal("interaction_check")
#		#Pressing E While On Phone (phone interaction)
#		if event.keycode == KEY_E and GameData.is_using_phone:
#			SignalController.emit_signal("phone_interacted")
#		#Pressing Q toggles phone open and close
#		if event.keycode == KEY_Q:
#			SignalController.emit_signal("toggle_phone")
