extends Node

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		#Pressing E While Not On Phone (object interaction)
		if event.keycode == KEY_E and !GameData.is_using_phone:
			SignalController.emit_signal("interaction_check")
		#Pressing E While On Phone (phone interaction)
		if event.keycode == KEY_E and GameData.is_using_phone:
			SignalController.emit_signal("phone_interacted")
		#Pressing Q toggles phone open and close
		if event.keycode == KEY_Q:
			SignalController.emit_signal("toggle_phone")
