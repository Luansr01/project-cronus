extends Node2D


var targeted_enemy : Enemy
var enemies = []

var label_attack_pattern: Label
var UI : Control
@onready var agua_attack_container: HBoxContainer = $"UI/Água Attack Pattern"
@onready var fogo_attack_container: HBoxContainer = $"UI/Fogo Attack Pattern"
@onready var grama_attack_container: HBoxContainer = $"UI/Grama Attack Pattern"
@onready var defesa_attack_pattern: HBoxContainer = $"UI/Defesa Attack Pattern"
const SETA_UP = preload("res://seta_up.tscn")
const SETA_RIGHT = preload("res://seta_right.tscn")
const SETA_LEFT = preload("res://seta_left.tscn")
const SETA_DOWN = preload("res://seta_down.tscn")
const SETA_BLANK = preload("res://seta_blank.tscn")

var att_patt_agua : AttackPattern
var att_patt_fogo : AttackPattern
var att_patt_grama : AttackPattern
var att_patt_defesa : AttackPattern

var Hero : Sprite2D
var player_defendendo : bool

@onready var player_input_sfx: AudioStreamPlayer = $"Sound Effects/Player Input SFX"
@onready var player_attack_sfx: AudioStreamPlayer = $"Sound Effects/Player Attack SFX"

@onready var player_input_sfx: AudioStreamPlayer = $"Sound Effects/Player Input SFX"
@onready var player_attack_sfx: AudioStreamPlayer = $"Sound Effects/Player Attack SFX"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	UI = get_node("UI")
	var slime = get_node("Slime")
	Hero = get_node("Hero")

	for i in get_children():
		if i is Enemy:
			enemies.append(i)		
			UI.add_icon_to_timeline("Slime", i)
			
	targeted_enemy = enemies[0]
			
	att_patt_agua =  AttackPattern.new(4, agua_attack_container)
	att_patt_fogo =  AttackPattern.new(4, fogo_attack_container)
	att_patt_grama =  AttackPattern.new(4, grama_attack_container)
	att_patt_defesa = AttackPattern.new(4, defesa_attack_pattern)
	player_defendendo = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	var attack_input = null
	if event.is_action_pressed("up"):
		attack_input = 0
		UI.press_key("up")
		player_input_sfx.play()		
	elif event.is_action_pressed("down"):
		attack_input = 2
		UI.press_key("down")
		player_input_sfx.play()
	elif event.is_action_pressed("left"):
		attack_input = 1
		UI.press_key("left")
		player_input_sfx.play()
	elif event.is_action_pressed("right"):
		attack_input = 3
		UI.press_key("right")
		player_input_sfx.play()
		
	
	if attack_input != null and targeted_enemy != null:
		if att_patt_agua.play_attack_pattern(attack_input):
			Hero.attack(targeted_enemy, Elementos.Elems.Água)
			UI.add_time(1)
			player_attack_sfx.play()
		if att_patt_fogo.play_attack_pattern(attack_input):
			Hero.attack(targeted_enemy, Elementos.Elems.Fogo)
			UI.add_time(1)
			player_attack_sfx.play()
		if att_patt_grama.play_attack_pattern(attack_input):
			Hero.attack(targeted_enemy, Elementos.Elems.Grama)
			UI.add_time(1)
			player_attack_sfx.play()
		if att_patt_defesa.play_attack_pattern(attack_input):
			player_defendendo = true	
			Hero.defend()
			print("Defesa!")
			
		
class AttackPattern:
	var attack_array : Array = []
	var array_size : int
	var attack_pattern_container : HBoxContainer
	var current_attack_pos : int
	
	func _init(tamanho : int, attack_pattern_container : HBoxContainer):
		attack_array.resize(tamanho)
		array_size = tamanho
		attack_array.fill(0)
		self.attack_pattern_container = attack_pattern_container
		current_attack_pos = 0
		randomize_att_pattern()
		place_pattern_container()
	
	func randomize_att_pattern() -> void:
		var rng = RandomNumberGenerator.new()	
		for i in range(array_size):
			attack_array[i] = rng.randi_range(0, 3)
		
	func place_pattern_container() -> void:
		_remove_all_children(attack_pattern_container)
		for dir in attack_array:
			match dir:
				0:
					attack_pattern_container.add_child(SETA_UP.instantiate())
				1:
					attack_pattern_container.add_child(SETA_LEFT.instantiate())
				2:
					attack_pattern_container.add_child(SETA_DOWN.instantiate())
				3:
					attack_pattern_container.add_child(SETA_RIGHT.instantiate())
		self.current_attack_pos = 0		
		
	func play_attack_pattern(player_dir) -> bool:
		if current_attack_pos < array_size:
			if  player_dir == attack_array[current_attack_pos]:
				var dir_icon_array = attack_pattern_container.get_children()
				if dir_icon_array.size() > 0:
					var curr_dir_icon : TextureRect = dir_icon_array[current_attack_pos]
					curr_dir_icon.modulate = Color(2, 2, 2)
				current_attack_pos += 1
			else:
				place_pattern_container()
		
		if current_attack_pos == array_size:
			randomize_att_pattern()
			self.place_pattern_container()
			return true
		return false
		
	func _remove_all_children(parent_node) -> void:
		var children = parent_node.get_children()
		for child in children:
			parent_node.remove_child(child) # Detach from the scene tree
			child.queue_free() # Safely delete and free memory	
