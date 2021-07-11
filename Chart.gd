extends Control

var click = false
var start = 0
var value = 25.0

onready var label = get_node("Label")
onready var circle = get_node("TextureProgress") 

func _ready():
	label.text = str(value) + "%"
	update_circle()
		

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			start = event.position.y
			click = true
		elif !event.pressed:
			click = false
		
	if event is InputEventMouseMotion && click:
		get_value(event.position.y)
		label.text = str(value) + "%"
		update_circle()
		
func update_circle():		
		circle.value = value
		var g = range_lerp(value, 0, 100, 1, 0)
		var r = range_lerp(value, 0, 100, 0, 1)
		circle.tint_progress = Color(r, g, 0)
		
func get_value(pos):
		value += (start - pos)*.2
		if value > 100:
			value = 100
		elif value < 0:
			value = 0
		start = pos 
		value = int(round(value))
		return value
