extends Control


@onready var animationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("RESET")
	pass # Replace with function body.

func play():
	animationPlayer.play("BlackTransition")
	
func play_reversed():
	animationPlayer.play_backwards("BlackTransition")

func play_reset():
	animationPlayer.play("RESET")
