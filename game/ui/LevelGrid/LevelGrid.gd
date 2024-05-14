extends Control

func _ready():
	Globals.clear_unactive_buttons()

var levels: Array = [	load("res://Levels/BaseLevel/BaseLevel.tscn"),
						load("res://Levels/FinishedLevels/Level1.tscn"),
						load("res://Levels/FinishedLevels/Level2.tscn"),
						load("res://Levels/FinishedLevels/Level3.tscn"),
						load("res://Levels/FinishedLevels/Level4.tscn"),
						load("res://Levels/FinishedLevels/Level5.tscn"),
						load("res://Levels/FinishedLevels/Level6.tscn")]



	
func _on_level_1_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levels[1])


func _on_level_2_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levels[2])


func _on_level_3_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levels[3])

func _on_level_4_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levels[4])


func _on_level_5_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levels[5])

func _on_level_6_pressed():
	TransitionController.black_play()
	SfxController.change_scene()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(levels[6])


func _on_level_7_pressed():
	SfxController.play_locked()


func _on_level_8_pressed():
	SfxController.play_locked()


func _on_level_9_pressed():
	SfxController.play_locked()
