extends Node

class_name DialogueParser

static func loadDB(jsonFile, table):
	var file: FileAccess = FileAccess.open(jsonFile, FileAccess.READ)
	var content: String = file.get_as_text()
	
	var json: JSON = JSON.new();
	var error = json.parse(content)
	var toReturn = null;
	if error == OK:
		var data = json.data
		toReturn = data[table]
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", content, " at line ", json.get_error_line())
	
	return toReturn
