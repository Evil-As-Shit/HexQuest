extends Sprite2D

var open_phone = false

func _ready():
	SignalController.on_phone.connect(on_phone)

func on_phone():
	if open_phone == false:
		get_node("Home").grab_focus()
		open_phone = true
	else:
		if(get_viewport().gui_get_focus_owner()!= null):
			get_viewport().gui_get_focus_owner().release_focus()
		open_phone = false

func _process(delta):
	if (open_phone):
		self.position = self.position.lerp(Vector2(15,180), delta*10)
	if (!open_phone):
		self.position = self.position.lerp(Vector2(15,645), delta*10)

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() and open_phone:
		if event.keycode == KEY_E:
			print(get_viewport().gui_get_focus_owner().name)
