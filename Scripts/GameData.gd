# Autoloaded Singleton

extends Node

var dict_dialogue = {}

var time_dialogue: float = .025
var dialogue_id: String = ""
var dialogue_choice_id: int = 0

var flag_displaying_dialogue: bool = false
var flag_waiting_dialogue_prompt: bool = false
var flag_waiting_dialogue_next: bool = false

var is_using_phone: bool = false
