extends Sprite2D

var scaleInicial
var opacity

func _ready() -> void:
	scaleInicial = scale
	scale.x -= 1
	scale.y -= 1
	opacity = 1
	
func _process(delta: float) -> void:
	if scale.x <= scaleInicial.x && scale.y <= scaleInicial.y :
		scale.x += 3 * delta
		scale.y += 3 * delta
	else :
		opacity -= 0.05
		self_modulate = Color(1,1,1, opacity)
		if opacity <= 0 :
			queue_free()
