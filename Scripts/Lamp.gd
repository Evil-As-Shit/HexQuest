extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.object_interacted.connect(object_interacted)
	pass # Replace with function body.

func object_interacted(object: String):
	if(object == "Lamp_Area"):
		if($Lamp_Sprite.animation == "off"):
			$Lamp_Sprite.play("on")
		else:
			$Lamp_Sprite.play("off")
