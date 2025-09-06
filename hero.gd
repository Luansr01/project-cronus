extends Sprite2D

@export var strength : int
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const ATTACK_ANIMATION_1 = preload("res://attack_animation1.tscn")
const ATTACK_ANIMATION_2 = preload("res://attack_animation2.tscn")
const ATTACK_ANIMATION_3 = preload("res://attack_animation3.tscn")
var attack_animation : AnimatedSprite2D

func attack(enemy : Enemy, type : Elementos.Elems):
	enemy.hit(strength, type)
	animated_sprite_2d.play("attack")
	if type == Elementos.Elems.Água:
		attack_animation = ATTACK_ANIMATION_1.instantiate()
	elif type == Elementos.Elems.Fogo:
		attack_animation = ATTACK_ANIMATION_2.instantiate()
	elif type == Elementos.Elems.Grama:
		attack_animation = ATTACK_ANIMATION_3.instantiate()
	enemy.add_child(attack_animation)

	await get_tree().create_timer(1.0).timeout
	animated_sprite_2d.play("default")
	
func defend():
	animated_sprite_2d.play("defend")
	await get_tree().create_timer(1.0).timeout
	animated_sprite_2d.play("default")
