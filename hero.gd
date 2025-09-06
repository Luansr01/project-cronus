extends Sprite2D

@export var strength : int

func attack(enemy : Enemy, type : Elementos.Elems):
	enemy.hit(strength, type)
