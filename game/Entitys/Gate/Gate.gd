extends Node2D
var icon_name: String = "star"

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var collisionShape2D: CollisionShape2D = $CollisionShape2D
@onready var iconComponent = $IconComponent

var has_body: bool = false
var open_texture: Texture = preload("res://Art/gate/gate_open.png")
var closed_texture: Texture = preload("res://Art/gate/gate_closed.png")
var i: int = 0

func _ready():
	get_parent().add_to_group("object")
	get_parent().add_to_group("has_states")
	icon_name = get_parent().get_meta("Icon")

func _process(delta):
	if i < 12:
		i += 1
		return
	i = 0
	if !Globals.unactive_buttons[icon_name]:
		collisionShape2D.disabled = true
		sprite2d.texture = open_texture
	elif has_body:
		collisionShape2D.disabled = true
		sprite2d.texture = open_texture
	else:
		collisionShape2D.disabled = false
		sprite2d.texture = closed_texture
		


func _on_area_2d_body_entered(body):
	var parent: Node2D = body.get_parent()
	if parent.is_in_group("player") or parent.is_in_group("box"):
		parent.add_to_group("static")
		has_body = true


func _on_area_2d_body_exited(body):
	var parent: Node2D = body.get_parent()
	parent.remove_from_group("static")
	has_body = false
