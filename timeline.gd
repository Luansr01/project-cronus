extends Control

# Speed is in seconds per unit
@export var speed = 0.1
@export var length = 400

var current_place = 0
var max_place
var timeline_position

var a : TextureRect

var timer : Timer

func _ready():
	timer = get_node("Timer")
	get_node("Line").size.x = length
	
	max_place = length / speed
	timer.start(speed)

func _process(delta):
	pass

func _on_timer_timeout() -> void:
	for i in get_children():
		if(i is TextureRect):
			if(i.position.x > 0):
				i.position.x -= 1
			else:
				i.position.x = length - i.size.x/2
				
			if i.position.x == length/2:
				print(i)
			
			var scale = -(pow(((i.position.x + i.size.x/2) - (length/2)), 2)/pow((length/2) * 2, 2)) + 1
			i.scale = Vector2(scale, scale)
			i.modulate = Color(1,1,1,-(pow(((i.position.x) - (length/2)), 2)/pow((length/2) * 1.2, 2)) + 1)
	
