extends Sprite2D

func _ready():
	SignalController.hexy_location.connect(change_z_index)

func change_z_index(location: String):
	if location == "Balcony_Area":
		self.z_index = 1
	else:
		self.z_index = 0

