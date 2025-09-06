extends Control

var key_dict = {}

func press_key(key):
	key_dict[key].modulate = Color(2,2,2,1)
	await get_tree().create_timer(0.1).timeout
	key_dict[key].modulate = Color(1,1,1,1)

	
func _ready():
	key_dict["up"] = get_node("Up")
	key_dict["down"] = get_node("Down")
	key_dict["left"] = get_node("Left")
	key_dict["right"] = get_node("Right")
