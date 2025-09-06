class_name Enemy

extends Node2D

signal enemy_died(enemy)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var target

@export var total_life: float
var cur_life: float
@export var enemy_type: Elementos.Elems
@export var damage = 2

var lifebar : ProgressBar
var is_active = false
signal enemy_has_died

func _ready() -> void:
	lifebar = get_node("ProgressBar")
	enemy_died.connect(get_parent()._on_slime_enemy_died)
	
	cur_life = total_life
	lifebar.max_value = total_life
	lifebar.value = cur_life
	
	animated_sprite.play("dying", -1.0, true)
	await get_tree().create_timer(1).timeout
	
	animated_sprite.play("default")

func hit(dano_base: float, tipo : Elementos.Elems):
	cur_life -= dano_base * Elementos.calc_efetividade(tipo, enemy_type)
	lifebar.value = cur_life
	if cur_life <= 0:
		self._die()
		return true
	return false
		
		
func _die():
	print("morri!")
	emit_signal("enemy_died", self)
	animated_sprite.play("dying")
	await get_tree().create_timer(2).timeout
	queue_free()

func action():
	target.hit(damage)
	animated_sprite.play("attacking")
	await get_tree().create_timer(0.5).timeout
	animated_sprite.play("default")
	
	
