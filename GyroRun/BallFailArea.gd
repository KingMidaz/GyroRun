extends Area2D

signal round_ended

func _ready():
	pass

func _process(delta):
	var overlap = get_overlapping_areas()
	if (overlap.size() > 0):
		print("GyroRun : Emitting round_ended")
		emit_signal("round_ended")