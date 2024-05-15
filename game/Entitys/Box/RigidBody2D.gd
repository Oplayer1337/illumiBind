extends RigidBody2D


@export var tile_size: int = 256
@onready var ray: RayCast2D = $RayCast2D
@onready var sprite2d: Sprite2D = $Sprite2D
@export var speed: int = 16
@onready var colorComponent = $ColorComponent
var target_position: Vector2 = Vector2()
var is_alive: bool = true
var group_to_move: String = String()

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * 256)
	get_parent().add_to_group("object")
	get_parent().add_to_group("has_states")
	get_parent().add_to_group("box")
	get_parent().add_to_group("movable")
	target_position = position.snapped(Vector2.ONE * tile_size)
	
	pass # Replace with function body.


func move_box(direction: Vector2) -> bool:
	ray.target_position = direction * tile_size * 0.8
	ray.force_raycast_update()
	
	var collider = ray.get_collider()
	if collider:
		
		if collider is CharacterBody2D:
			#print(collider)
			#print(collider.get_parent())
			self.find_child("CollisionShape2D").disabled = true
			#await get_tree().create_timer(0.01).timeout
			await change_position(direction)
			await get_tree().create_timer(0.03).timeout
			self.find_child("CollisionShape2D").disabled = false
			return true
		
		if collider.get_parent().is_in_group('static'):
			change_position(direction)
			return true
		# case when box collider is on another box
		if collider.get_parent().is_in_group('movable'):
			var box: Node2D = collider.get_parent()
			group_to_move = get_group_name(box)
			var entitys_to_move = get_tree().get_nodes_in_group(group_to_move)
			
			for entity in entitys_to_move:
				if !Globals.boxes_to_move.has(entity):
					Globals.boxes_pool[entity] = null
					Globals.boxes_to_move[entity] = 'check'
			
			if !collider.move_box(direction):
				Globals.boxes_to_move[box] = 'stopped'
				Globals.boxes_pool.erase(box)
				return false
			
			Globals.boxes_pool.erase(box)
			Globals.boxes_to_move[box] = 'moved'
			
			change_position(direction)
			
			return true
			
		
	
	if !ray.is_colliding():
		change_position(direction)
		return true
	return false

func get_group_name(box: Node2D) -> String:
	var box_groups = box.get_groups()
	for group in box_groups:
		if group.begins_with("group_Box"):
			return group
			
	return 'default'

func change_position(direction: Vector2):
	
	target_position = position + direction * tile_size
	position = position.move_toward(target_position, speed)
