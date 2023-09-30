extends StaticBody2D

@export var dialogue_ids: PackedStringArray = [ "NPC000" ]

@onready var object_id : int = get_node("Object_Id").get_instance_id()

func _ready():
	SignalController.interaction_detected.connect(object_interacted)

func object_interacted(object: int, _player: CharacterBody2D):
	if(object == object_id):
		DialogueController.object_interacted(dialogue_ids)
