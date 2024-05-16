extends Area2D

@onready var iconComponent = $IconComponent
@onready var sprite2D: Sprite2D = $Sprite2D
var icon_name: String = ""
var is_alive: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_to_group("static")
	icon_name = get_parent().get_meta("Icon")
	Globals.unactive_buttons[icon_name][get_parent()] = null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	sprite2D.visible = false
	Globals.unactive_buttons[icon_name].erase(get_parent())
	
	pass # Replace with function body.
	

func _on_body_exited(body):
	
	Globals.unactive_buttons[icon_name][get_parent()] = null
	
	sprite2D.visible = true
	pass # Replace with function body.
