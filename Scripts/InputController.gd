extends Node

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_E and !GameData.is_using_phone:
			SignalController.emit_signal("object_interacted")
		else:
			SignalController.emit_signal("phone_interacted")
		if event.keycode == KEY_Q:
			SignalController.emit_signal("toggle_phone")
