extends TextureRect

var parent

func toggle_active():
	parent.toggle_active()

func _process(delta):
	if parent == null:
		queue_free()
