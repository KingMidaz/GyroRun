extends RigidBody2D

var roll_speed = 50

func _ready():
	pass

func _process(delta):
	pass
	
func _integrate_forces(state):
	var accel = Input.get_accelerometer()
	#print("GyroRun Accel:" + String(accel))
	var accelVec = Vector2(accel.x, -accel.y)
	var accelAng = accelVec.angle()
	
	set_angular_velocity(0)
	set_applied_force(accelVec * roll_speed)
	pass
