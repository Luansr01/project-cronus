class_name Enemy

extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var total_life: float
var cur_life: float
@export var enemy_type: Elementos.Elems

var lifebar : ProgressBar
var is_active = false

func _ready() -> void:
	lifebar = get_node("ProgressBar")
	
	cur_life = total_life
	lifebar.max_value = total_life
	lifebar.value = cur_life

func hit(dano_base: float, tipo : Elementos.Elems):
	cur_life -= dano_base * Elementos.calc_efetividade(tipo, enemy_type)
	lifebar.value = cur_life
	if cur_life <= 0:
		self._die()
		
func _die():
	print("morri!")
	animated_sprite.play("dying")
	await get_tree().create_timer(2).timeout
	queue_free()
	
func toggle_active():
	is_active = not is_active
	
