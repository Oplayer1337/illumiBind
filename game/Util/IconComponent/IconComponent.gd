extends Node

@export var name_of_icon: String = 'empty'
var entity_color: Color = Color(0,0,0,1)
var entity_name: String = 'default'
var group_name: String = 'group_default_black'
var icon_textures: Dictionary = {	'star': load("res://Art/icons/icon_star.png"),
									'heart': load("res://Art/icons/icon_heart.png"),
									'triangle': load("res://Art/icons/icon_triangle.png"),
									'diamond': load("res://Art/icons/icon_diamond.png"),
									'bulb': load("res://Art/icons/icon_bulb.png")}

var list_of_all_entity_names = ['Button', 'Gate']
func _ready():
	update_icon()
	update_group_membership()

func update_icon():
	if get_parent().has_meta("Icon"):
		name_of_icon = get_parent().get_meta("Icon")
		var sprite: Sprite2D = Sprite2D.new()
		sprite.texture = icon_textures[name_of_icon]
		add_child(sprite)
		sprite.scale *= 0.17
		sprite.position = sprite.position + Vector2(48,48)
		sprite.z_index = 50
	update_group_membership()

func update_group_membership():
	entity_name = get_parent().get_name()
	for entity in list_of_all_entity_names:
		if entity_name.begins_with(entity):
			entity_name = entity
	group_name = "group_" + entity_name + "_" + name_of_icon
	var groups = get_groups()
	get_parent().add_to_group(group_name)
