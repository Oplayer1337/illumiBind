extends Control

var levelSelection = load("res://ui/level_selection/LevelSelection.tscn")
var controls = load("res://ui/controls_screen/ControlsScreen.tscn")

func _ready():
	TransitionController.reset()
	get_tree().paused = false

func _on_play_pressed():
	Globals.clear_unactive_buttons()
	
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levelSelection)


func _on_exit_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()


func _on_illumi_bind_pressed():
	SfxController.play_joke()


func _on_controls_pressed():
	Globals.clear_unactive_buttons()
	
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(controls)
