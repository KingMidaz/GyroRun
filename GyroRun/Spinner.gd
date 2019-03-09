extends StaticBody2D

var rps = float(20)/float(60) 

func _ready():
	print("GyroRun : Spinner created")

func _process(delta):
	rotate(rps*delta*2)