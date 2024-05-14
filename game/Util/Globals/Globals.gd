extends Node

var is_fullscreen: bool = false
var is_muted: bool = false

var current_level: int = 1
var boxes_to_move: Dictionary = {}
var boxes_pool: Dictionary = {}
var unactive_buttons: Dictionary = {	'star': {},
										'heart': {},
										'diamond': {},
										'tirangle': {},
										'bulb': {}
									}

func clear_unactive_buttons():
	unactive_buttons = {	'star': {},
							'heart': {},
							'diamond': {},
							'tirangle': {},
							'bulb': {}
						}

func _input(event):
	if Input.is_action_just_pressed('ui_fullscreen'):
		if !is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			is_fullscreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
			is_fullscreen = false
			
	elif Input.is_action_just_pressed("ui_mute"):
		if !is_muted:
			pass
			is_muted = true
		else:
			pass
			is_muted = false
	
