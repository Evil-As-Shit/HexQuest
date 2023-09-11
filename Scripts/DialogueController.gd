extends Node

class_name DialogueController

static func finish():
	SignalController.emit_signal("finish_dialogue")

static func choose():
	print("choice made! ", GameData.dialogue_choice_id)
	SignalController.emit_signal("close_dialogue")

static func next():
	var dialogue = GameData.dict_dialogue[GameData.dialogue_id]
	if (dialogue.has("isEnd")):
		SignalController.emit_signal("close_dialogue")
	elif (dialogue.has("divert")):
		var next_id = dialogue["divert"]
		SignalController.emit_signal("display_dialogue", next_id)
	else:
		print("ERROR (DialogueController): ", dialogue["id"], " does not have  'isEnd' or 'divert'")
		SignalController.emit_signal("close_dialogue")
