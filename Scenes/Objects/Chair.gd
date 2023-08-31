extends StaticBody2D
@onready var object_id : int = get_node("Object_Id").get_instance_id()
@onready var chair_collision = self.get_node("Chair_Collision")
@onready var sit_position = self.get_node("Sit_Position").global_position

func _ready():
	SignalController.interaction_detected.connect(object_interacted)

func object_interacted(object: int,player: CharacterBody2D):
	if(object == object_id):
		print(object_id)
		if !player.is_sitting:
			chair_collision.disabled = true
			player.current_state = player.STATE.SITTING
			player.global_position = sit_position
			chair_collision.disabled = false
			player.z_index = 1
