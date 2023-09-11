extends StaticBody2D

@export var dialogue_id: String = "NPC000"

@onready var object_id : int = get_node("Object_Id").get_instance_id()

func _ready():
	SignalController.interaction_detected.connect(object_interacted)

func object_interacted(object: int, _player: CharacterBody2D):
	if(object == object_id):
		SignalController.emit_signal("display_dialogue", dialogue_id)
