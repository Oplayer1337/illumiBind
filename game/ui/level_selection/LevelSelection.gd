extends Control

var mainMenu = load("res://ui/main_menu/MainMenu.tscn")

func _ready():
	TransitionController.reset()
	get_tree().paused = false




func _on_menu_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(mainMenu)
