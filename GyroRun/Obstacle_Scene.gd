extends Node2D

var plank = preload("res://Plank.tscn")
var hole = preload("res://Hole.tscn")
var spinner = preload("res://Spinner.tscn")
var plank_instance = null
var hole_instance = null
var spinner_instance = null

var obstacles = []

var window_size = global.window_size
var move_speed = 3
var number_obstacles = randi()%(7-4)+4

var controls_reversed = false

func _ready():
	
	randomize()
	
	if randi()%100 < 25:
		controls_reversed = true
	else:
		controls_reversed = false
		
	# 0: Standard Level
	# 1: Spinner
	# 2: Mixed
	# 3: Moving Planks
	
	match randi()%2:
		0:
			print("GyroRun: Standard Level")
			while obstacles.size() < number_obstacles:
				print("GyroRun : Obstacles " + String(obstacles.size()))
				match randi()%2:
					0:
						print("GyroRun : Creating Plank")
						plank_instance = plank.instance()
						
						get_node("Obstacle_Point").add_child(plank_instance)
						
						var offset = Vector2(randi()%int(window_size.x), randi()%int(window_size.y))
						plank_instance.global_translate(offset)
						print("GyroRun: " + String(offset))
						while(plank_instance.get_node("Plank_Overlap_Area").get_overlapping_areas().size() > 0
								and not overcrowded(offset)):
							offset = Vector2(randi()%int(window_size.x), randi()%int(window_size.y))
							plank_instance.global_translate(offset)
						
						obstacles.push_back(plank_instance)
					1:
						print("GyroRun : Creating Hole")
						hole_instance = hole.instance()
						
						get_node("Obstacle_Point").add_child(hole_instance)
						
						var offset = Vector2(randi()%int(window_size.x), randi()%int(window_size.y))
						hole_instance.global_translate(offset)
						print("GyroRun: " + String(offset))
						while(hole_instance.get_overlapping_areas().size() > 0 and not overcrowded(offset)):
							offset = Vector2(randi()%int(window_size.x), randi()%int(window_size.y))
							hole_instance.global_translate(offset)
						
						obstacles.push_back(hole_instance)
		1:
			print("GyroRun: Spinner")
			for i in range(0, 4):
				print("GyroRun : Obstacles " + String(i))
				print("GyroRun : Creating Spinner")
				spinner_instance = spinner.instance()
					
				get_node("Obstacle_Point").add_child(spinner_instance)
					
				var offset = Vector2(randi()%int(window_size.x), randi()%int(window_size.y))
				spinner_instance.global_translate(offset)
				print("GyroRun: " + String(offset))
				while(spinner_instance.get_node("Spinner_Overlap_Area").get_overlapping_areas().size() > 0
					and not overcrowded(offset)):
					offset = Vector2(randi()%int(window_size.x), randi()%int(window_size.y))
					spinner_instance.global_translate(offset)
						
				obstacles.push_back(spinner_instance)

func _process(delta):
	#print("GyroRun : Obstacle Page " + String(global_transform))
	global_translate(Vector2(0, move_speed))

func set_level_speed(speed):
	move_speed = speed
	
func overcrowded(point):
	var cnt = 0
	for obstacle in obstacles:
		if obstacle.global_position <= (point.y + 300) and obstacle.global_position >= (point.y - 300):
			cnt  += 1
	if cnt >= 2:
		return true
	return false