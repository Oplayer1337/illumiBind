extends Node2D
class State:
	var object_states: Dictionary = {}  # Dictionary to hold the state of each object by its instance ID
	
	

var move_history = []
var base_state: State
@export var delay: int = 0.8
@export var collision_delay: float = 0.5
var undo_pressed: bool = false

@export var base_timer_speed: float = 0.3
@export var timer_cap: float = 0.06
@export var incrementor: float = 0.9


func save_state():
	var state = State.new()
	#print("-----------------------")
	for obj in get_tree().get_nodes_in_group("object"):
		print(obj)
		var obj_state = {}
		
		var collision_shape = obj.find_child("CollisionShape2D")
		var collision_shape_parent = collision_shape.get_parent()
		
		obj_state["position"] = collision_shape_parent.global_position
		obj_state["collision"] = collision_shape.disabled
		obj_state["visible"] = obj.visible
		obj_state["alive"] = collision_shape_parent.is_alive
		#print(obj_state)
		#print()
		state.object_states[obj.get_instance_id()] = obj_state
	
		
	move_history.append(state)

func restore_state(state: State, curr_state: State):
	for obj in get_tree().get_nodes_in_group("object"):
		var id = obj.get_instance_id()
		
		print("----------------------")
		if id in state.object_states:
			var obj_state = state.object_states[id]
			var collision_shape = obj.find_child("CollisionShape2D")		
			var collision_shape_parent = collision_shape.get_parent()
			print(obj)
			print(obj_state)
			print()
			
			if curr_state.object_states[id]["alive"]:
				collision_shape_parent.global_position = obj_state["position"]
				collision_shape_parent.is_alive = obj_state["alive"]
				obj.visible = obj_state["visible"]

	
	
func disable_collisions_for_undo():
	for body in get_tree().get_nodes_in_group("object"):
		var collision_shape: CollisionShape2D = body.find_child("CollisionShape2D")
		if collision_shape:
			collision_shape.disabled = true

func enable_collisions_after_undo(state: State):
	for obj in get_tree().get_nodes_in_group("object"):
		var id = obj.get_instance_id()
		
		if id in state.object_states:
			var obj_state = state.object_states[id]
			var collision_shape = obj.find_child("CollisionShape2D")
			collision_shape.disabled =  obj_state["collision"]
			

func on_player_save_game():
	save_state()  # Call the function that saves the game state
	
func undo_move():
	while undo_pressed:
		await get_tree().create_timer(base_timer_speed).timeout
		if move_history.size() < 2:
			return
		
		if !undo_pressed:
			return
		SfxController.player_undo()
		var last_state = move_history[-2]
		var curr_state = move_history[-1]
		move_history.pop_back()
		
		disable_collisions_for_undo()
		await get_tree().create_timer(0.015).timeout
		
		restore_state(last_state,curr_state)
		
		await get_tree().create_timer(0.015).timeout
		enable_collisions_after_undo(last_state)
		
		if base_timer_speed > timer_cap:
			base_timer_speed *= incrementor

func _ready():
	TransitionController.reset()
	var player = get_node("Player/CharacterBody2D")
	player.save_game.connect(on_player_save_game)
	save_state()
	base_state = move_history[0]
	
# trigger an undo
func _input(event):
	if event.is_action_pressed("ui_undo"):
		undo_pressed = true
		undo_move()
	elif event.is_action_released("ui_undo"):
		base_timer_speed = 0.3
		undo_pressed = false
		
	if event.is_action_pressed('ui_restart'):
		get_tree().reload_current_scene()
		Globals.clear_unactive_buttons()
		
		return
		
		
		
