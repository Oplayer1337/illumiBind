extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed('ui_pause') and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed('ui_pause') and get_tree().paused:
		resume()
		
# Called when the node enters the scene tree for the first time.
@export var is_fullscreen: bool = false
func _ready():
	$AnimationPlayer.play("RESET")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	testEsc()
	pass


func _on_resume_pressed():
	if get_tree().paused:
		resume()


func _on_restart_pressed():
	if get_tree().paused:
		resume()
		get_tree().reload_current_scene()
		Globals.clear_unactive_buttons()

func _on_quit_pressed():
	if get_tree().paused:
		resume()
		Globals.clear_unactive_buttons()
		get_tree().change_scene_to_file("res://ui/main_menu/MainMenu.tscn")
