extends AnimatedSprite2D

const FIREBLAST = preload("res://Scenes/fire_blast.tscn")
var fireblast : AnimatedSprite2D
var posInicial

func _ready() :
	posInicial = position
	position.x -= 256
	position.y -= 256

func _process(delta: float) :
	position.x += 512 * delta
	position.y += 512 * delta
	if position.x >= posInicial.x && position.y >= posInicial.y :
		fireblast = FIREBLAST.instantiate()
		get_parent().add_child(fireblast)
		queue_free()
