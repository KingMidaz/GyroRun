extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var accel = Input.get_accelerometer()
	print("GyroRun Accel:" + String(accel))
	translate(Vector2(2*accel.x, -2*accel.y))
	pass