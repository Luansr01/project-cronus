extends TileMapLayer

const fim = -700
const inicio = 350

func _process(delta: float) -> void:
	position.x -= 10 * delta
	if position.x <= fim :
		position.x = inicio
