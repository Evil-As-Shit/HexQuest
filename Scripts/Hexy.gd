extends CharacterBody2D

# First look at Phone.gd stuff (it's easier), then go here
# My general thoughts on Hexy.gd: it should handle physics stuff (movement, interactions)
# Maaaybe sprite stuff
# But it shouldn't handle input. It should just respond to input data
# (I can do a deeper dive once Phone.gd is done)

#Movement/Phone Variables
enum STATE {IDLE, WALK, PHONE}
@export var move_speed: float = 50.0
@export var move_acc: float = 500.0
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

#Room and Object Interactions Variables
var query_area:PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
var query_objects:PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
var current_area : String = ""
var current_object : String = ""

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

func _ready():
	#Sets the PhysicsPointQueryParameters2D for the room and object detection
	query_area.collide_with_areas = true
	query_area.collide_with_bodies = false
	query_area.collision_mask = 2 #2 is bit value, layer is 2.
	query_objects.collide_with_areas = true
	query_objects.collide_with_bodies = false
	query_objects.collision_mask = 4  #4 is value, layer is 3.
	SignalController.interaction_check.connect(interating)
#Looks for Area2D objects in scene on collision mask 3. Used for knowing what Objects Hexy is interacting with.

func interating():
	query_objects.position = global_position
	var result:Array = get_world_2d().direct_space_state.intersect_point(query_objects,1)
	if (not result.is_empty()):
		current_object = result[0].collider.name
		SignalController.emit_signal("interaction_detected", current_object)
		print("interacting with: ", current_object)
	else:
		print("no object detected...")

#Looks for Area2D objects in scene on collision mask 2. Used for knowing what Room Hexy is in.
func current_location():
	query_area.position = global_position
	var result:Array = get_world_2d().direct_space_state.intersect_point(query_area,1)
	if !result.is_empty() and result[0].collider.name != current_area:
			current_area = result[0].collider.name
			SignalController.emit_signal("hexy_location",current_area)		#Signal emitted is a String value.
			print("area entered: " + current_area)

func _physics_process(delta: float) -> void:
	var move_input = get_directional_input()
	if(move_input != Vector2.ZERO):
		update_animation_parameters(move_input)
		self.current_state = STATE.WALK
		velocity = velocity.move_toward(move_input * move_speed, move_acc * delta)
	else:
		if (!GameData.is_using_phone):
			self.current_state = STATE.IDLE
		else:
			self.current_state = STATE.PHONE
		velocity = Vector2.ZERO
	move_and_slide()
	current_location()

func get_directional_input():
	if GameData.is_using_phone:
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
