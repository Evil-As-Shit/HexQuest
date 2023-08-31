extends StaticBody2D

@onready var object_id : int = get_node("Object_Id").get_instance_id()
@onready var lamp_sprite = self.get_node("Lamp_Sprite")

func _ready():
	SignalController.interaction_detected.connect(object_interacted)

func object_interacted(object: int, _player: CharacterBody2D):
	if(object == object_id):
		if(lamp_sprite.animation == "off"):
			lamp_sprite.play("on")
		else:
			lamp_sprite.play("off")
