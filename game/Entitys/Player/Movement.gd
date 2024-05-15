extends CharacterBody2D
class_name Movement


@export var tile_size: int = 256
@onready var ray: RayCast2D = $RayCast2D
@export var base_move_delay: float = 0.25
var move_delay: float = 0.25
@export var move_delay_cap: float = 0.15
@export var incrementor: float = 0.95
@export var speed: int = 16

#var boxes_to_move: Dictionary = {}

var is_alive: bool = true
var can_move = true
var target_position: Vector2 = Vector2()
var delay_from_last_input: float = 0.20
var is_moving: bool = false
var group_to_move: String = 'default'
signal save_game

func _ready():
	position = position.snapped(Vector2.ONE * 256)
	target_position = position.snapped(Vector2.ONE * tile_size)
	pass
	
	

var previous_input: Vector2 = Vector2(0,1)
func _physics_process(delta):
	if !is_alive:
		return
	delay_from_last_input += delta
	
	var movementVector: Vector2 = Vector2(int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left')),
	 int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up')))
	
	
	if movementVector[0] and movementVector[1]:
		if previous_input[0] == 1:
			movementVector[0] = 0
		elif previous_input[1] == 1:
			movementVector[1] = 0
		else:
			movementVector[0] = 0
	
	if Input.is_action_pressed('ui_undo'):
		movementVector = Vector2.ZERO
		return
		
	if movementVector == Vector2.ZERO:
		is_moving = false
		move_delay = base_move_delay
	else:
		is_moving = true
	
		
	if delay_from_last_input > move_delay and movementVector:
		move(movementVector)
		#previous_input = movementVector
		#if is_moving and move_delay > move_delay_cap:
			#move_delay *= incrementor
		#
	
	


func move(direction: Vector2):
	#print(Globals.unactive_buttons)
	Globals.boxes_to_move = {}
	Globals.boxes_pool = {}
	ray.target_position = direction * tile_size * 0.8
	ray.force_raycast_update()
	var collider = ray.get_collider()
	
	if collider:
			
		# Case when collider meets with boxes
		if collider.get_parent().is_in_group('movable'):
			var box: Node2D = collider.get_parent()
			group_to_move = get_group_name(box)
			var entitys_to_move = get_tree().get_nodes_in_group(group_to_move)
			#for entity in entitys_to_move:
				#if !Globals.boxes_to_move.has(entity):
					#Globals.boxes_to_move[entity] = 'check'
					#Globals.boxes_pool[entity] = null
					
			if Globals.boxes_to_move.has(box):
				if Globals.boxes_to_move[box] in ['stopped','moved']:
					Globals.boxes_to_move[box] = 'stopped'
					Globals.boxes_pool.erase(box)
					return
			if !collider.move_box(direction):
				Globals.boxes_to_move[box] = 'stopped'
				Globals.boxes_pool.erase(box)
				return
			else:
				for entity in entitys_to_move:
					if !Globals.boxes_to_move.has(entity):
						Globals.boxes_to_move[entity] = 'check'
						Globals.boxes_pool[entity] = null
				Globals.boxes_to_move[box] = 'moved'
				Globals.boxes_pool.erase(box)
				update_boxes(direction)
				change_position(direction)
				SfxController.player_move()
				return
				
			#while Globals.boxes_pool:
				#var temp = Globals.boxes_pool
				#for linked in temp:
					#pass
	#
					#temp = linked.find_child("CollisionShape2D").get_parent()
					#
					#if !temp.move_box(direction):
						#Globals.boxes_to_move[linked] = 'stopped'
						#Globals.boxes_pool.erase(linked)
					#else:
						#Globals.boxes_to_move[linked] = 'moved'
						#Globals.boxes_pool.erase(linked)
						#
					#var linked_ray: RayCast2D = linked.find_child("RayCast2D")
					#linked_ray.target_position = direction * tile_size
					#linked_ray.force_raycast_update()
					#var linked_collider = linked_ray.get_collider()
					##print(linked_collider)
					#if !linked_collider:
						#Globals.boxes_to_move[linked] = 'moved'
						#Globals.boxes_pool.erase(linked)
						#change_linked_box_position(linked,direction)
						#continue
						#
					#if linked_collider.get_parent().is_in_group("movable"):
						#var linked_group_to_move = get_group_name(linked)
						#var linked_entitys_to_move = get_tree().get_nodes_in_group(linked_group_to_move)
						#for linked_entity in linked_entitys_to_move:
							#if !Globals.boxes_to_move.has(linked_entity):
								#Globals.boxes_to_move[linked_entity] = 'check'
								#Globals.boxes_pool[linked_entity] = null
						#
						#if !linked_collider.move_box(direction):
							#Globals.boxes_to_move[linked] = 'stopped'
							#Globals.boxes_pool.erase(linked)
							#continue
						#else:
							#Globals.boxes_to_move[linked] = 'moved'
							#Globals.boxes_pool.erase(linked)
							#change_linked_box_position(linked, direction)
							#continue
					#else:
							#Globals.boxes_to_move[linked] = 'stopped'
							#Globals.boxes_pool.erase(linked)
							#continue
						
					
				
		if collider.get_parent().is_in_group('static'):
			change_position(direction)
			SfxController.player_move()
		return
				
			
	# Direct movement, if player has free space in front of them
	if !ray.is_colliding() and is_moving:
		change_position(direction)
		SfxController.player_move()
		return
		
		



func update_boxes(direction: Vector2):
	while Globals.boxes_pool:
		var temp = Globals.boxes_pool
		for linked in temp:
			pass

			temp = linked.find_child("CollisionShape2D").get_parent()
			
			if Globals.boxes_to_move.has(linked):
				if Globals.boxes_to_move[linked] in ['stopped','moved']:
					Globals.boxes_to_move[linked] = 'stopped'
					Globals.boxes_pool.erase(linked)
					return
			
			if not await temp.move_box(direction):
				Globals.boxes_to_move[linked] = 'stopped'
				Globals.boxes_pool.erase(linked)
			else:
				Globals.boxes_to_move[linked] = 'moved'
				Globals.boxes_pool.erase(linked)
	pass
func get_group_name(box: Node2D) -> String:
	var box_groups = box.get_groups()
	for group in box_groups:
		if group.begins_with("group_Box"):
			return group
			
	return 'default'
	
func change_position(direction: Vector2):
	#print(Globals.boxes_to_move)
	#print(Globals.boxes_pool)
	#print()
	delay_from_last_input = 0.0
	target_position = position + direction * tile_size
	position = position.move_toward(target_position, speed)
	save_game.emit()
	
func change_linked_box_position(box:Node2D, direction: Vector2):
	var body = box.find_child("CollisionShape2D").get_parent()
	var linked_target_position = body.position + direction * tile_size
	body.position = body.position.move_toward(linked_target_position, speed)

