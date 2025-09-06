extends AnimatedSprite2D

const ICEBREAK = preload("res://Scenes/ice_shatter.tscn")
var ice_break : AnimatedSprite2D
var yInicial

func _ready() :
	yInicial = position.y
	position.y -= 256

func _process(delta: float) :
	position.y += 512 * delta
	if position.y >= yInicial :
		ice_break = ICEBREAK.instantiate()
		get_parent().add_child(ice_break)
		queue_free()
	
		
