extends StaticBody2D

func _ready():
	SignalController.object_interacted.connect(object_interacted)

func object_interacted(object: String):
	if(object == "Lamp_Area"):
		if($Lamp_Sprite.animation == "off"):
			$Lamp_Sprite.play("on")
		else:
			$Lamp_Sprite.play("off")
