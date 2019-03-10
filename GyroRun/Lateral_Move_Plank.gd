extends StaticBody2D

var window_width = global.window_size.x
var right = true
var plank_move_speed = 5

func _ready():
	pass

func _process(delta):
	if right:
		global_translate(Vector2(plank_move_speed, 0))
	else:
		global_translate(Vector2(-plank_move_speed, 0))
	
	if global_position.x < 0:
		right = true
	
	if global_position.x > window_width:
		right = false