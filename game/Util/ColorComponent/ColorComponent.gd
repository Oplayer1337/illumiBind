extends Node

# The color property of the component
@export var name_of_color: String = 'black'
var entity_color: Color = Color(0,0,0,1)
var entity_name: String = 'default'
var group_name: String = 'group_default_black'
@onready var sprite: Sprite2D = $Sprite2D
# The group name is derived from the color to ensure uniqueness
var list_off_all_colors: Dictionary = {	'black': Color(0,0,0,1),
										'red': Color(0.8,0.2,0.2,1),
										'green': Color(0.2,0.8,0.2,1),
										'blue': Color(0.2,0.2,0.8,1),
										'rg': Color(0.8,0.8,0.2,1),
										'rb': Color(0.8,0.2,0.8,1),
										'gb': Color(0.2,0.8,0.8,1),
										'white': Color(0.8,0.8,0.8,1)} 
var list_of_all_entity_names = ['Box', 'Player', 'Button']
func _ready():
	# Set the sprite color and group membership on ready
	update_color()
	update_group_membership()

func update_color():
	if get_parent().has_meta("Color"):
		
		name_of_color = get_parent().get_meta("Color")
		
	entity_color = list_off_all_colors[name_of_color]
	#var sprite = get_node("../RigidBody2D/Sprite2D")  # Adjust the path as needed
	var sprite = get_parent().find_child("Sprite2D")
	if sprite:
		sprite.modulate = entity_color
	# Update the group name based on the color
	# Ensure the box is part of the right group
	update_group_membership()

func update_group_membership():
	# First, clear existing group memberships to avoid duplicates
	
	entity_name = get_parent().get_name()
	for entity in list_of_all_entity_names:
		if entity_name.begins_with(entity):
			entity_name = entity
	group_name = "group_" + entity_name + "_" + name_of_color
	var groups = get_groups()
	#for g in groups:
		#if g.begins_with("group_"):
			#remove_from_group(g)
	# Add to the new group
	get_parent().add_to_group(group_name)

# maybe will depricate and work in box script
func move_similar_boxes(direction: Vector2):
	# Retrieve all boxes in the same group and move them
	var boxes = get_tree().get_nodes_in_group(group_name)
	for box in boxes:
		if box != self and box.has_method("move_box"):
			box.move_box(direction)
