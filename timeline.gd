extends Control

# Speed is in seconds per unit
@export var speed = 0.1
@export var length = 400

var icon_prefab = preload("res://icon.tscn")

var current_place = 0
var max_place

var current_active:
	set(x):
		current_active = x
		current_active.action()

var a : TextureRect
var marker : ColorRect
var timer : Timer

func check_if_any_end() -> bool:
	for i in get_children():
		if  i is TextureRect and (i.position.x > length - 50 or i.position.x < 50):
			return true
	return false

func _ready():
	timer = get_node("Timer")
	marker = get_node("Marker")

	get_node("Line").size.x = length
	
	marker.position.x = length/2
	
	
	max_place = length / speed
	timer.start(speed)

func _process(delta):
	pass
	
func add_icon_to_timeline(type, parent):
	while check_if_any_end():
		await get_tree().create_timer(3).timeout
		
	var new_icon = icon_prefab.instantiate()
	new_icon.position.x = length
	add_child(new_icon)
	new_icon.parent = parent
	

	if type == "Slime":
		new_icon.texture = load("res://art/slime_icon.png")

func _on_timer_timeout() -> void:
	for i in get_children():
		if(i is TextureRect):
			if(i.position.x > 0):
				i.position.x -= 1
			else:
				i.position.x = length - i.size.x/2
				
			if i.position.x + i.size.x/2 == length/2:
				current_active = i
			
			var scale = -(pow(((i.position.x + i.size.x/2) - (length/2)), 2)/pow((length/2) * 2, 2)) + 1
			i.scale = Vector2(scale, scale)
			i.modulate = Color(i.modulate.r,i.modulate.g,i.modulate.b,-(pow(((i.position.x) - (length/2)), 2)/pow((length/2) * 1.2, 2)) + 1)
	
