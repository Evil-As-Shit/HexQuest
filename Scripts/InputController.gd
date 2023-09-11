extends Node


func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		if GameData.is_using_phone:
			match event.keycode:
				KEY_E:
					SignalController.emit_signal("phone_interacted")
				KEY_Q:
					SignalController.emit_signal("toggle_phone")
		elif GameData.flag_displaying_dialogue:
			SignalController.emit_signal("finish_dialogue")
		elif GameData.flag_waiting_dialogue_prompt:
			print("choice made! ", GameData.dialogue_choice_id)
			SignalController.emit_signal("close_dialogue")
		elif GameData.flag_waiting_dialogue_next:
			SignalController.emit_signal("close_dialogue")
		else:
			match event.keycode:
				KEY_E:
					SignalController.emit_signal("interaction_check")
				KEY_Q:
					SignalController.emit_signal("toggle_phone")
#		#Pressing E While Not On Phone (object interaction)
#		if event.keycode == KEY_E and !GameData.is_using_phone:
#			SignalController.emit_signal("interaction_check")
#		#Pressing E While On Phone (phone interaction)
#		if event.keycode == KEY_E and GameData.is_using_phone:
#			SignalController.emit_signal("phone_interacted")
#		#Pressing Q toggles phone open and close
#		if event.keycode == KEY_Q:
#			SignalController.emit_signal("toggle_phone")
