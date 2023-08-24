extends Sprite2D

var first_time : bool = false
var shader_mat = load("res://The Game/2 -  The Apartments/PixelateShader.tres")
func _ready():
	SignalController.hexy_location.connect(change_z_index)
	shader_mat.set_shader_parameter("time", 0)

func set_shader_value(value: float):
		var shader_mat = load("res://The Game/2 -  The Apartments/PixelateShader.tres")
		shader_mat.set_shader_parameter("time", value)

func change_z_index(location: String):
	if location == "Balcony_Area":
		self.z_index = 1
	else:
		if first_time == false:
			var tween = get_tree().create_tween()
			tween.tween_method(set_shader_value,0.0,1.57,0.7)
			first_time = true
		self.z_index = 0

func pixel_fade():
	
	pass

func _physics_process(_delta):
	
	pass
