extends Node2D

@onready var sprite_fragile: Sprite2D = $SpriteFragile
var is_fragile: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if !get_parent().has_meta("Fragile"):
		pass
		
	if get_parent().get_meta("Fragile") == true:
		sprite_fragile.visible = true
		is_fragile = true
		sprite_fragile.z_index = 50
	pass # Replace with function body.


func _process(delta):
	if is_fragile:
		#print(get_parent().find_child("CollisionShape2D").get_parent().global_position)
		#print(sprite_fragile.global_position)
		sprite_fragile.global_position = get_parent().find_child("CollisionShape2D").get_parent().global_position + Vector2(124,124)
