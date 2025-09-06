extends Sprite2D

signal player_got_hit(damage)

@export var strength : int
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const ATTACK_ANIMATION_1 = preload("res://attack_animation1.tscn")
const ATTACK_ANIMATION_2 = preload("res://attack_animation2.tscn")
const ATTACK_ANIMATION_3 = preload("res://attack_animation3.tscn")

const RUNE_FIRE = preload("res://Scenes/rune_fire.tscn")
const RUNE_WATER = preload("res://Scenes/rune_water.tscn")
const RUNE_GRASS = preload("res://Scenes/rune_grass.tscn")
const RUNE_SHIELD = preload("res://Scenes/rune_shield.tscn")

var attack_animation : AnimatedSprite2D
var rune : Sprite2D

signal has_killed_enemy

var is_defending : bool

func intro():
	animated_sprite_2d.play("drink")
	await get_tree().create_timer(2).timeout 
	rune = RUNE_FIRE.instantiate()
	add_child(rune)
	await get_tree().create_timer(.5).timeout
	rune = RUNE_WATER.instantiate()
	add_child(rune)
	await get_tree().create_timer(.5).timeout
	rune = RUNE_GRASS.instantiate()
	add_child(rune)
	await get_tree().create_timer(.5).timeout
	animated_sprite_2d.play("default")
	await get_tree().create_timer(1).timeout

func attack(enemy : Enemy, type : Elementos.Elems):
	if enemy.hit(strength, type):
		has_killed_enemy.emit()
		
	animated_sprite_2d.play("attack")
	if type == Elementos.Elems.Água:
		attack_animation = ATTACK_ANIMATION_1.instantiate()
		rune = RUNE_WATER.instantiate()
	elif type == Elementos.Elems.Fogo:
		attack_animation = ATTACK_ANIMATION_2.instantiate()
		rune = RUNE_FIRE.instantiate()
	elif type == Elementos.Elems.Grama:
		attack_animation = ATTACK_ANIMATION_3.instantiate()
		rune = RUNE_GRASS.instantiate()
	enemy.add_child(attack_animation)
	add_child(rune)
	#await get_tree().create_timer(0.5).timeout
	#attack_animation.queue_free()

	await get_tree().create_timer(1).timeout
	animated_sprite_2d.play("default")
	
func hit(damage):
	if not is_defending:
		animated_sprite_2d.play("hit")
		animated_sprite_2d.material.set("shader_parameter/is_flashing", true)
		player_got_hit.emit(damage)
		await get_tree().create_timer(0.1).timeout
		animated_sprite_2d.material.set("shader_parameter/is_flashing", false)
		animated_sprite_2d.play("default")
		
	
func defend():
	is_defending = true
	rune = RUNE_SHIELD.instantiate()
	add_child(rune)
	animated_sprite_2d.play("defend")
	await get_tree().create_timer(1.0).timeout
	animated_sprite_2d.play("default")
	is_defending = false
