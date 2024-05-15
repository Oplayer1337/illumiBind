extends Node

@onready var background: AudioStreamPlayer = $Background
@onready var changescene: AudioStreamPlayer = $ChangeScene
@onready var levelcompleted: AudioStreamPlayer = $LevelCompleted
@onready var move_sound: AudioStreamPlayer = $Move
@onready var undo_sound: AudioStreamPlayer = $Undo
@onready var fragile_break: AudioStreamPlayer = $FragileBreak
@onready var joke = $Joke
@onready var locked = $Locked

var bus_idx = AudioServer.get_bus_index("Master")
var is_muted: bool = false
func _ready():
	pass
	background.play()
	AudioServer.set_bus_mute(bus_idx, false)
	
func change_scene():
	changescene.play()

func player_move():
	move_sound.play()
	
func player_undo():
	undo_sound.play()
	
func level_complete():
	levelcompleted.play()

func play_joke():
	joke.play()
	
func play_locked():
	locked.play()
	
func play_fragile():
	fragile_break.play()
	
func _input(event):
	if Input.is_action_just_pressed("ui_mute"):
		if !is_muted:
			AudioServer.set_bus_mute(bus_idx, true)
			is_muted = true
		else:
			AudioServer.set_bus_mute(bus_idx, false)
			is_muted = false
