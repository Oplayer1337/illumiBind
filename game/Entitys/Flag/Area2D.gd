extends Area2D


# Called when the node enters the scene tree for the first time.
@onready var completionscreen = load("res://ui/completion_screen/CompletetionScreen.tscn")
func _ready():
	get_parent().add_to_group("object")
	get_parent().add_to_group("static")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	


func _on_body_entered(body):
	if body is CharacterBody2D:
		Globals.current_level = get_parent().get_meta("Level")
		TransitionController.white_play()
		await get_tree().create_timer(0.3).timeout
		SfxController.level_complete()
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_packed(completionscreen)
		Globals.clear_unactive_buttons()
