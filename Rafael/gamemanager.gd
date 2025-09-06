extends Node2D

@export var attack_pattern = [0,0,2,2]
var current_att_pattern_pos
var label_attack_pattern: Label
var UI : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI = get_node("UI")
	
	current_att_pattern_pos = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	var attack_input = null
	if event.is_action_pressed("up"):
		attack_input = 0
		UI.press_key("up")
	elif event.is_action_pressed("down"):
		attack_input = 2
		UI.press_key("down")
	elif event.is_action_pressed("left"):
		attack_input = 1
		UI.press_key("left")
	elif event.is_action_pressed("right"):
		attack_input = 3
		UI.press_key("right")

		
	if current_att_pattern_pos < attack_pattern.size():
		if attack_input != null and attack_input == attack_pattern[current_att_pattern_pos]:
			current_att_pattern_pos += 1
	else:
		print("Ataque!")
		UI.add_time(1)
		current_att_pattern_pos = 0
