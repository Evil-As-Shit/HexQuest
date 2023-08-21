extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	
	SignalController.display_dialogue.connect(on_display_dialogue)

func on_display_dialogue(id: String):
	visible = true;
	
	var text = GameData.dict_dialogue[id]["text"]
	var expression = GameData.dict_dialogue[id]["expression"]
	var t = null if (expression == "null") else load("res://Assets/ui/Avatars/" + expression + ".png")
	
	$Label.text = text
	$PortraitTexture.texture = t
	
