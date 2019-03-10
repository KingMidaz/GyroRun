extends Sprite

func _ready():
	get_node("Ball_Speed_Slider").value = global.ball_speed
	get_node("Ball_Speed_Slider/Ball_Speed_Count").text = String(global.ball_speed)
	
	get_node("Max_Obstacle_Slider").value = global.max_obstacles
	get_node("Max_Obstacle_Slider/Max_Obstacle_Count").text = String(global.max_obstacles)
	
	get_node("Min_Obstacle_Slider").value = global.min_obstacles
	get_node("Min_Obstacle_Slider/Min_Obstacle_Count").text = String(global.min_obstacles)

func _on_Ball_Speed_Slider_value_changed(value):
	global.ball_speed = value
	global.load_data["Settings"]["Ball"] = global.ball_speed
	global.save_play_data("user://play.data", global.load_data)
	get_node("Ball_Speed_Slider/Ball_Speed_Count").text = String(value)

func _on_Max_Obstacle_Slider_value_changed(value):
	global.max_obstacles = max(value, global.min_obstacles)
	global.load_data["Settings"]["Max"] = global.max_obstacles
	global.save_play_data("user://play.data", global.load_data)
	get_node("Max_Obstacle_Slider/Max_Obstacle_Count").text = String(value)

func _on_Min_Obstacle_Slider_value_changed(value):
	global.min_obstacles = min(value, global.max_obstacles)
	global.load_data["Settings"]["Min"] = global.min_obstacles
	global.save_play_data("user://play.data", global.load_data)
	get_node("Min_Obstacle_Slider/Min_Obstacle_Count").text = String(value)


func _on_Back_Button_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")
