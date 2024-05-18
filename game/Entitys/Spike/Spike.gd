extends Node2D

func _ready():
	pass # Replace with function body.



func _on_area_2d_body_entered(obj):
	var body: Node2D = obj.get_parent()
	if !body.has_meta("Fragile"):
		return
	if body.get_meta("Fragile") == true:
		body.global_position = -body.global_position*3
		body.find_child("CollisionShape2D").disabled = true
		body.visible = false	
		body.find_child("CollisionShape2D").get_parent().is_alive = false
		SfxController.play_fragile()
