extends StaticBody2D

@onready var object_id : int = get_node("Object_Id").get_instance_id()
@onready var chair_collision = self.get_node("Chair_Collision")

func _ready():
	SignalController.interaction_detected.connect(object_interacted)

func object_interacted(object: int,player: CharacterBody2D):
	if(object == object_id):
		if !player.is_sitting:
			player.current_state = player.STATE.SITTING
			player.global_position = self.global_position + Vector2(0,-3)
			player.z_index = 1
