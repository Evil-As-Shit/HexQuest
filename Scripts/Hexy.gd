extends CharacterBody2D

enum STATE {IDLE, WALK, PHONE}

@export var move_speed: float = 50.0
@export var move_acc: float = 500.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
var on_phone: bool = false
var current_state = STATE.IDLE : set = set_current_state

func set_current_state(new_state):
	if(new_state == current_state):
		return
	match(new_state):
		STATE.IDLE:
			state_machine.travel("Idle")
		STATE.WALK:
			state_machine.travel("Walk")
		STATE.PHONE:
			state_machine.travel("Phone")
	current_state = new_state

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_Q:
			SignalController.emit_signal("phone_switch")
			if on_phone == false:
				on_phone = true
			else:
				on_phone = false

func _physics_process(delta: float) -> void:
	var move_input = get_directional_input()
	if(move_input != Vector2.ZERO):
		update_animation_parameters(move_input)
		self.current_state = STATE.WALK
		velocity = velocity.move_toward(move_input * move_speed, move_acc * delta)
	else:
		if (on_phone == false):
			self.current_state = STATE.IDLE
		else:
			self.current_state = STATE.PHONE
		velocity = Vector2.ZERO
	move_and_slide()

func get_directional_input():
	if on_phone == true:
		var move_input_vector = Vector2.ZERO
		return move_input_vector.normalized()
	else:
		var move_input_vector = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
		return move_input_vector.normalized()


func update_animation_parameters(move_input : Vector2):
	animation_tree.set("parameters/Idle/blend_position",move_input)
	animation_tree.set("parameters/Walk/blend_position",move_input)
	animation_tree.set("parameters/Phone/blend_position",move_input)
