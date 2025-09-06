extends Control

# Speed is in seconds per unit
@export var speed = 0.1
@export var length = 100

var current_place = 0
var max_place
var timeline_position


var timer : Timer
var player_pointer : TextureRect

func _ready():
	timer = get_node("Timer")
	player_pointer = get_node("TextureRect")
	
	max_place = length / speed
	
	player_pointer.position.x = length
	timer.start(speed)

func _process(delta):
	pass

func _on_timer_timeout() -> void:
	for i in get_children():
		if(i is TextureRect):
			if(i.position.x > 0):
				i.position.x -= 1
			else:
				i.position.x = length
			i.scale.x = -(pow((i.position.x - (length/2)), 2)/pow((length/2), 2)) + 1
			print(str(i.position.x) + " : " + str(-(pow((i.position.x - (length*2)), 2)/pow((length*2), 2)) + 1))
