extends Control

@export var initial_max_time : float
@export var starting_time : float

var timer : Timer
var bar : TextureProgressBar

var max_time : float:
	set(v):
		max_time = v
		bar.max_value = v
var current_time : float:
	set(v):
		current_time = clamp(v, 0, max_time)
		bar.value = current_time

func set_time(v):
	timer.start(clamp(v, 0, max_time))
	
func _ready():
	timer = get_node("Timer")
	bar = get_node("LifetimeBar")
	
	max_time = initial_max_time
	
	timer.one_shot = true
	set_time(starting_time)

func _process(delta):
	current_time = timer.time_left
