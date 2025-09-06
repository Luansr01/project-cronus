extends AnimatedSprite2D

var yInicial

func _ready() :
	yInicial = position.y
	position.y -= 256

func _process(delta: float) :
	position.y += 512 * delta
	if position.y >= yInicial :
		queue_free()
