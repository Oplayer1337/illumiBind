extends Control

@onready var menu = load("res://ui/main_menu/MainMenu.tscn")

func _ready():
	TransitionController.reset()
	
func _on_back_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(menu)
