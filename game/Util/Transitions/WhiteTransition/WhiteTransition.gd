extends Control


@onready var animationPlayer = $AnimationPlayer
func _ready():
	animationPlayer.play("RESET")

func play():
	animationPlayer.play("WhiteTransition")
	
func play_reversed():
	animationPlayer.play_backwards("WhiteTransition")

func play_reset():
	animationPlayer.play("RESET")
