extends Control

var lifetime : Control
var keys : Control

func add_time(x : int):
	lifetime.add_time(x)

func press_key(key):
	keys.press_key(key)

func _ready():
	lifetime = get_node("Lifetime")
	keys = get_node("Keys")
