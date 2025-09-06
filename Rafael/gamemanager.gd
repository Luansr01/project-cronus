extends Node2D

@export var attack_pattern = [0,1,2,3]
var current_att_pattern_pos
var label_attack_pattern: Label
var UI : Control
@onready var attack_pattern_container: HBoxContainer = $UI/AttackPatternContainer
const SETA_UP = preload("res://seta_up.tscn")
const SETA_RIGHT = preload("res://seta_right.tscn")
const SETA_LEFT = preload("res://seta_left.tscn")
const SETA_DOWN = preload("res://seta_down.tscn")
const SETA_BLANK = preload("res://seta_blank.tscn")

func remove_all_children(parent_node) -> void:
	var children = parent_node.get_children()
	for child in children:
		parent_node.remove_child(child) # Detach from the scene tree
		child.queue_free() # Safely delete and free memory

func randomize_att_pattern() -> void:
	var rng = RandomNumberGenerator.new()	
	for i in range(attack_pattern.size()):
		attack_pattern[i] = rng.randi_range(0, 3)


func place_pattern_container(att_pattern: Array) -> void:
	remove_all_children(attack_pattern_container)
	for dir in att_pattern:
		match dir:
			0:
				attack_pattern_container.add_child(SETA_UP.instantiate())
			1:
				attack_pattern_container.add_child(SETA_LEFT.instantiate())
			2:
				attack_pattern_container.add_child(SETA_DOWN.instantiate())
			3:
				attack_pattern_container.add_child(SETA_RIGHT.instantiate())
	current_att_pattern_pos = 0

func play_attack_pattern(att_pat, player_dir) -> void:
	if current_att_pattern_pos < att_pat.size():
		if  player_dir == att_pat[current_att_pattern_pos]:
			var curr_dir_icon : TextureRect = attack_pattern_container.get_children()[current_att_pattern_pos]
			curr_dir_icon.modulate = Color(2, 2, 2)
			current_att_pattern_pos += 1
	
	if current_att_pattern_pos == att_pat.size():
		print("Attack!")
		randomize_att_pattern()
		place_pattern_container(attack_pattern)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI = get_node("UI")
	var slime = get_node("Slime")
	current_att_pattern_pos = 0


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
		
	if event.is_action_pressed("ui_accept"):
		place_pattern_container(attack_pattern)
	
	if attack_input != null:
		play_attack_pattern(attack_pattern, attack_input)
		
