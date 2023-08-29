extends StaticBody2D

var object_name : String = ""
@onready var sit_position = $Sit_Position.global_position

func _ready():
	SignalController.interaction_detected.connect(object_interacted)
	object_name = "Chair"

func object_interacted(object: String,player: CharacterBody2D):
	if(object == object_name):
		if !player.is_sitting:
			player.current_state = player.STATE.SITTING
			print(player.global_position,sit_position)
			player.global_position = sit_position
			print(player.global_position,sit_position)
			player.z_index = 1
