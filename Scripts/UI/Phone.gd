extends Sprite2D

var on_phone = false

func _ready():
	pass

func phone():
	if on_phone == true:
		get_node("Home").grab_focus()
	else:
		if(get_viewport().gui_get_focus_owner()!= null):
			get_viewport().gui_get_focus_owner().release_focus()

func _process(delta):
	if (on_phone):
		self.position = self.position.lerp(Vector2(15,180), delta*10)
	if (!on_phone):
		self.position = self.position.lerp(Vector2(15,645), delta*10)

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() :
		if event.keycode == KEY_Q:
			if on_phone == false:
				on_phone = true
			else:
				on_phone = false
			phone()
			SignalController.emit_signal("on_phone")
		if event.keycode == KEY_E and on_phone == true:
			print(get_viewport().gui_get_focus_owner().name)
