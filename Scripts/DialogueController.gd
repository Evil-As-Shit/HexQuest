extends Node

class_name DialogueController

static func finish():
	SignalController.emit_signal("finish_dialogue")

static func choose():
	SignalController.emit_signal("close_dialogue")
	var choice: String = "choice_%s" % GameData.dialogue_choice_id
	print(GameData.dict_dialogue[GameData.dialogue_id][choice])
	object_interacted(GameData.dict_dialogue[GameData.dialogue_id][choice])
	

static func next():
	var dialogue = GameData.dict_dialogue[GameData.dialogue_id]
	if (dialogue.has("isEnd")):
		SignalController.emit_signal("close_dialogue")
	elif (dialogue.has("divert")):
		var next_id = dialogue["divert"]
		display_dialogue(next_id)
	else:
		print("ERROR (DialogueController): ", dialogue["id"], " does not have  'isEnd' or 'divert'")
		SignalController.emit_signal("close_dialogue")
		
static func object_interacted(dialogue_ids: PackedStringArray):
	#iterates through array to find first dialogue that passes a tag requirement
	var is_passed: bool = false
	for i in dialogue_ids.size():
		var dialogue_id: String = dialogue_ids[i]
		var dialogue = GameData.dict_dialogue[dialogue_id]
		if (dialogue.has("tagRequired")):
			var tag: String = dialogue["tagRequired"]
			if (GameData.dialogue_tags.has(tag)):
				is_passed = true
				display_dialogue(dialogue_id)
				break
		else:
			display_dialogue(dialogue_id)
			is_passed = true
	if (is_passed == false): print("DialogueControoller: No dialogue meets requirements! ", dialogue_ids)

static func display_dialogue(dialogue_id: String):
	SignalController.emit_signal("display_dialogue", dialogue_id)
	var dialogue = GameData.dict_dialogue[dialogue_id]
	if (dialogue.has("tagAdd")):
		var tag: String = dialogue["tagAdd"]
		GameData.dialogue_tags.append(tag)
