extends Node2D

@export var attack_pattern = [0,0,2,2]
var current_att_pattern_pos
@onready var label_attack_pattern: Label = $"Cena-ui/Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_att_pattern_pos = 0

	label_attack_pattern.text = str(traduz_vector_dir(attack_pattern))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	var attack_input = -1
	if event.is_action_pressed("up"):
		attack_input = 0
	if event.is_action_pressed("down"):
		attack_input = 2
	if event.is_action_pressed("left"):
		attack_input = 1
	if event.is_action_pressed("right"):
		attack_input = 3
		
	if current_att_pattern_pos < attack_pattern.size():
		if attack_input >= 0 and attack_input == attack_pattern[current_att_pattern_pos]:
			current_att_pattern_pos += 1
	else:
		print("Ataque!")
		current_att_pattern_pos = 0
		
func traduz_vector_dir(attack_pattern : Array) -> String:
	var dir_string
	for num in attack_pattern:
		dir_string += traduz_num_dir(num) + " "
	return dir_string

func traduz_num_dir(num) -> String:
	match num:
		0:
			return "up"
		1:
			return "left"
		2:
			return "down"
		3:
			return "right"					
		_: 
			return "nodir"
	
