extends TextureRect

var parent

func action():
	parent.action()

func _process(delta):
	if parent == null:
		queue_free()
