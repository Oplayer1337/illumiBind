extends Node

@onready var background: AudioStreamPlayer = $Background
@onready var changescene: AudioStreamPlayer = $ChangeScene
@onready var levelcompleted: AudioStreamPlayer = $LevelCompleted
@onready var move_sound: AudioStreamPlayer = $Move
@onready var undo_sound: AudioStreamPlayer = $Undo
@onready var joke = $Joke
@onready var locked = $Locked

func _ready():
	pass
	background.play()

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
	
