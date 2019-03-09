extends Sprite

onready var leaderboard = get_node("High_Scores")

func _ready():
	var high_scores = ""
	
	global.load_data["Scores"].sort_custom(ScoreSort, "sort")
	print("GyroRun: Scores " + String(global.load_data["Scores"]))
	for i in range(global.load_data["Scores"].size()):
		high_scores += (String(i+1) + ".\t" + String(global.load_data["Scores"][i]["Name"]) 
		+ "\t" +  String(global.load_data["Scores"][i]["Score"]) + "\n")
		
	leaderboard.text = high_scores

func _on_Back_Button_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

class ScoreSort:
	static func sort(a, b):
		if a["Score"] > b["Score"]:
			return true
		return false