extends Sprite2D

var inUI = false

func _ready():
	SignalController.phone_switch.connect(on_phone)

func on_phone():
	if inUI == false:
		inUI = true
	else:
		inUI = false

func _process(delta):
	if (inUI):
		self.position = self.position.lerp(Vector2(15,180), delta*10) 
	if (!inUI):
		self.position = self.position.lerp(Vector2(15,645), delta*10) 
