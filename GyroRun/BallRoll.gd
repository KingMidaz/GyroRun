extends Node2D

var obstacle_scene = preload("res://Obstacle_Scene.tscn")

var new_obstacle_scene = null
var old_obstacle_scene = null

func _ready():
	global.score = 0
	print("GyroRun : Window Size " + String(OS.get_window_size()))
	
	new_obstacle_scene = obstacle_scene.instance()
	get_node("Obstacle_Page_Parent").add_child(new_obstacle_scene)

func _process(delta):
	global.score = global.score + delta
	get_node("Score").text = String(round(global.score))
	
	#print("GyroRun : Obstacle Page " + String(new_obstacle_scene.global_transform.origin.y))
	
	if new_obstacle_scene.global_transform.origin.y >= 0:
		old_obstacle_scene = new_obstacle_scene
		new_obstacle_scene = obstacle_scene.instance()
		get_node("Obstacle_Page_Parent").add_child(new_obstacle_scene)

func _on_round_ended():
	print("GyroRun: Ending round")
	if global.ad_to_be_shown:
		global.firebase.show_interstitial_ad()
		global.ad_to_be_shown = false
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")
