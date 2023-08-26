extends StaticBody2D
class_name object

var object_name : String = ""


func _ready():
	SignalController.interaction_detected.connect(object_interacted)
	object_name = "Lamp_Area"

func _object_code():
	if($Lamp_Sprite.animation == "off"):
		$Lamp_Sprite.play("on")
	else:
		$Lamp_Sprite.play("off")

func object_interacted(object: String):
	if(object == object_name):
		_object_code()

