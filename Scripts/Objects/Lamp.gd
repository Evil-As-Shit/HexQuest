extends StaticBody2D

var object_name : String = ""

func _ready():
	SignalController.interaction_detected.connect(object_interacted)
	object_name = "Lamp"

func object_interacted(object: String):
	if(object == object_name):
		if($Lamp_Sprite.animation == "off"):
			$Lamp_Sprite.play("on")
		else:
			$Lamp_Sprite.play("off")

