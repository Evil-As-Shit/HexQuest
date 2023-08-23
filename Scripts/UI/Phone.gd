extends Sprite2D

var inUI = false

func _ready():
	SignalController.phone_switch.connect(on_phone)

func on_phone():
	if inUI == false:
		inUI = true
		get_node("Home").grab_focus()
	else:
		get_viewport().gui_get_focus_owner().release_focus()
		inUI = false

func _process(delta):
	if (inUI):
		self.position = self.position.lerp(Vector2(15,180), delta*10) 
	if (!inUI):
		self.position = self.position.lerp(Vector2(15,645), delta*10) 

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() and inUI:
		if event.keycode == KEY_E:
			print(get_viewport().gui_get_focus_owner().name)
