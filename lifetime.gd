extends Node

@export var initial_max_time_v : float
@export var starting_time_v : float

@onready var timer : Timer = $Timer
@onready var bar : TextureProgressBar = $LifetimeBar

var max_time_v : float:
	set(v):
		max_time_v = v
		if(bar):
			bar.max_value = v
var current_time_v : float:
	set(v):
		current_time_v = clamp(v, 0, max_time_v)
		if(bar):
			bar.value = current_time_v

func set_time(v):
	current_time_v = v
	timer.wait_time = current_time_v

func _ready():
	max_time_v = initial_max_time_v
	current_time_v = starting_time_v
	
	timer.one_shot = true
	timer.start()

func _update():
	current_time_v = timer.wait_time
