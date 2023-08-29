extends StaticBody2D

var object_name : String = ""
@onready var sit_position = $Sit_Position.global_position
@onready var chair_collision = $Chair_Collision

func _ready():
	SignalController.interaction_detected.connect(object_interacted)
	object_name = "Chair"

func object_interacted(object: String,player: CharacterBody2D):
	if(object == object_name):
		if !player.is_sitting:
			chair_collision.disabled = true
			player.current_state = player.STATE.SITTING
			player.global_position = sit_position
			chair_collision.disabled = false
			player.z_index = 1
