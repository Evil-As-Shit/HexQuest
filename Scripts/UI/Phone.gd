extends Control

func _ready():
	SignalController.toggle_phone.connect(phone)
	SignalController.phone_interacted.connect(phone_input)

func phone():
	if !GameData.is_using_phone:
		GameData.is_using_phone = true
		get_node("Home").grab_focus()
	else:
		if(get_viewport().gui_get_focus_owner()!= null):
			get_viewport().gui_get_focus_owner().release_focus()
		GameData.is_using_phone = false

func phone_input():
	print(get_viewport().gui_get_focus_owner().name)

func _process(delta):
	# cool! didn't know you could do this
	if (GameData.is_using_phone):
		self.position = self.position.lerp(Vector2(15,180), delta*10)
	else: # else:
		self.position = self.position.lerp(Vector2(15,645), delta*10)

# This code is good, but it doesn't belong here. A class should do one thing
# Phone.gd controls the phone graphics/nodes
# Something else (InputController?) should handle all input.
# It can check flag_using_phone or flag_displaying_dialogue, and handle input accordingly
# That way, all input is in one place (or all in a separate folder)
# That other class can emit the "GameData.is_using_phone" signal, and Phone.gd can respond
#func _input(event):
#	if event.keycode == KEY_E and GameData.is_using_phone == true:
#		print(get_viewport().gui_get_focus_owner().name)
