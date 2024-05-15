extends Node2D


func _ready():
	get_parent().add_to_group("object")
	get_parent().add_to_group("has_states")
	get_parent().add_to_group("player")
	var sprite: Sprite2D = get_parent().find_child("Sprite2D")
	sprite.z_index = 40


