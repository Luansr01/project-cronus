class_name Enemy

extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var total_life: float
var cur_life: float
@export var enemy_type: Elementos.Elems

func _ready() -> void:
	cur_life = total_life

func hit(dano_base: float, tipo : Elementos.Elems):
	cur_life -= dano_base * Elementos.calc_efetividade(tipo, enemy_type)
	if cur_life <= 0:
		self._die()
		
func _die():
	print("morri!")
	animated_sprite.play("dying")
	await get_tree().create_timer(2).timeout
	queue_free()
	
