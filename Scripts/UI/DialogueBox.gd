extends Control

var timer_display: float = 0.0

var label_size_x_portrait: float = 305.0
var label_pos_x_portrait: float = 135.0
var label_size_x: float = 400.0
var label_pos_x: float = 40.0
var label_size_y: float = 90.0
var label_pos_y: float = 20.0

func _ready():
	visible = false
	
	$Button0.visible = false
	$Button1.visible = false
	$Button0.focus_entered.connect(on_choice_focus.bind(0))
	$Button1.focus_entered.connect(on_choice_focus.bind(1))
	
	SignalController.display_dialogue.connect(on_display_dialogue)
	SignalController.finish_dialogue.connect(on_finish_dialogue)
	SignalController.close_dialogue.connect(on_close_dialogue)
	
func _process(delta):
	if (timer_display > 0):
		timer_display -= delta
		if (timer_display <= 0):
			$Label.visible_characters += 1
			if ($Label.visible_ratio >= 1):
				on_finish_dialogue()
			else:
				while (timer_display < 0): timer_display += GameData.time_dialogue

func on_choice_focus(n: int):
	GameData.dialogue_choice_id = n

func on_close_dialogue():
	GameData.flag_waiting_dialogue_next = false
	visible = false

func on_display_dialogue(id: String):
	GameData.dialogue_id = id
	GameData.flag_displaying_dialogue = true
	
	var text = GameData.dict_dialogue[id]["text"]
	var expression = GameData.dict_dialogue[id]["expression"]
	var t = null
	if (expression == "null"):
		$Label.size = Vector2(label_size_x, label_size_y)
		$Label.position = Vector2(label_pos_x, label_pos_y)
	else:
		t = load("res://Assets/ui/Avatars/" + expression + ".png")
		$Label.size = Vector2(label_size_x_portrait, label_size_y)
		$Label.position = Vector2(label_pos_x_portrait, label_pos_y)
	
	$Label.text = text
	$Label.visible_characters = 0
	$PortraitTexture.texture = t
	$Button0.visible = false
	$Button1.visible = false
	visible = true
	
	timer_display = GameData.time_dialogue

func on_finish_dialogue():
	GameData.flag_displaying_dialogue = false
	$Label.visible_ratio = 1
	timer_display = 0
	var dialogue = GameData.dict_dialogue[GameData.dialogue_id]
	if (dialogue.has("choices")):
		var choices = dialogue["choices"]
		$Button0.text = choices[0]
		$Button1.text = choices[1]
		$Button0.visible = true
		$Button1.visible = true
		$Button0.grab_focus()
		GameData.flag_waiting_dialogue_prompt = true
	else:
		GameData.flag_waiting_dialogue_next = true
