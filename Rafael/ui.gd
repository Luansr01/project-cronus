extends Control

var lifetime : Control
var keys : Control
var timeline : Control

func add_icon_to_timeline(type, parent):
	timeline.add_icon_to_timeline(type, parent)

func add_time(x : int):
	lifetime.add_time(x)

func press_key(key):
	keys.press_key(key)

func _ready():
	lifetime = get_node("Lifetime")
	keys = get_node("Keys")
	timeline = get_node("Timeline")
