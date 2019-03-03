extends Area2D

func _ready():
	pass

func _process(delta):
	var overlap = get_overlapping_areas()
	if (overlap.size() > 0):
		get_tree().change_scene("res://MainMenu.tscn")
	pass
