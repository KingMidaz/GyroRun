extends Node2D

func _ready():
	pass

func _process(delta):
	var accel = Input.get_accelerometer()
	print("GyroRun Accel:" + String(accel))
	translate(Vector2(2*accel.x, -2*accel.y))
	pass
