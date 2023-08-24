extends Control

var timer_display: float = 0.0

func _ready():
	visible = false
	
	SignalController.display_dialogue.connect(on_display_dialogue)
	
func _process(delta):
	if (timer_display > 0):
		timer_display -= delta
		if (timer_display <= 0):
			$Label.visible_characters += 1
			if ($Label.visible_ratio >= 1):
				GameData.flag_displaying_dialogue = false
			else:
				while (timer_display < 0): timer_display += GameData.time_dialogue

func on_display_dialogue(id: String):
	visible = true;
	GameData.flag_displaying_dialogue = true
	
	var text = GameData.dict_dialogue[id]["text"]
	var expression = GameData.dict_dialogue[id]["expression"]
	var t = null if (expression == "null") else load("res://Assets/ui/Avatars/" + expression + ".png")
	
	$Label.text = text
	$Label.visible_characters = 0
	$PortraitTexture.texture = t
	
	timer_display = GameData.time_dialogue
