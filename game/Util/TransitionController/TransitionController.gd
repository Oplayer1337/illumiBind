extends Node

@onready var black_transition = $BlackTransition
@onready var white_transition = $WhiteTransition
func _ready():
	black_transition.play_reset()
	white_transition.play_reset()

func black_play():
	black_transition.play()
	
func white_play():
	white_transition.play()
	
func reset():
	black_transition.play_reset()
	white_transition.play_reset()
