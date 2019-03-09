extends RigidBody2D

var roll_speed = 80
var controls_reversed = false

func _ready():
	pass

func _process(delta):
	pass

func _integrate_forces(state):
	var accel = Input.get_accelerometer()
	var accelVec = Vector2(accel.x, -accel.y)
	var accelAng = accelVec.angle()
	set_angular_velocity(0)
	if controls_reversed:
		set_applied_force(-accelVec * roll_speed)
	else:
		set_applied_force(accelVec * roll_speed)
