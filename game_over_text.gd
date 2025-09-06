extends RichTextLabel

@onready var timer : Timer = $Timer

func _ready():
	timer.start(1)
	pass

func _update(delta):
	pass

func _on_timer_timeout() -> void:
	print("a")
	
	if modulate.a == 0:
		modulate.a = 1
	else:
		modulate.a = 0
	
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://main Menu.tscn")
