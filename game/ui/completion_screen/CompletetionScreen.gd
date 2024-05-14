extends Control


func _ready():
	get_tree().paused = false
	TransitionController.reset()	



func _on_menu_pressed():
	var menu = load("res://ui/main_menu/MainMenu.tscn")
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(menu)
	pass # Replace with function body.


func _on_next_pressed():
	var menu = load("res://ui/main_menu/MainMenu.tscn")
	var str_level: String = str(Globals.current_level + 1)
	print(str_level)
	if str_level == "1000":
		TransitionController.black_play()
		SfxController.change_scene()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_packed(menu)
		return
		
	var next_level_path: String = "res://Levels/FinishedLevels/Level" + str_level + ".tscn"
	var nextlevel = load(next_level_path)
	
	print(next_level_path)
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(nextlevel)
