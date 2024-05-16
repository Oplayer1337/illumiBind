extends Node2D

@onready var spike_up = $Spike_up
@onready var spike_down = $Spike_down
@onready var spike_left = $Spike_left
@onready var spike_right = $Spike_right
@onready var spikes: Array = [spike_up, spike_down, spike_left, spike_right]

@onready var obj = get_parent()
@onready var obj_collision = obj.find_child("CollisionShape2D")
@onready var body = obj_collision.get_parent()

func _ready():
	
	if !get_parent().has_meta("Spiked"):
		spike_down.queue_free()
		spike_up.queue_free()
		spike_left.queue_free()
		spike_right.queue_free()
		spikes = []
		return
		
	var spike_index: int = get_parent().get_meta("Spiked")
	var temp = []
	for spike in spikes:
		if spike_index % 2 == 0:
			spike.queue_free()
		else:
			temp.append(spike)
		spike_index /= 2
		
	spikes = temp
	for spike in spikes:
		spike.find_child("Sprite2D").z_index = 51
		spike.visible = true
	
	


func _process(delta):
	
	if spike_up in spikes:
		spike_up.position = body.position + Vector2(0,-256)
	
	if spike_down in spikes:
		spike_down.position = body.position + Vector2(256,512)
	
	if spike_right in spikes:
		spike_right.position = body.position + Vector2(512,0)
	
	if spike_left in spikes:
		spike_left.position = body.position + Vector2(-256,256)
	pass
