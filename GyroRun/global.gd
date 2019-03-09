extends Node

var firebase = Engine.get_singleton("FireBase")
var ad_to_be_shown = false
var time_between_ads = 180
var time_to_next_ad = time_between_ads
var interstitial_loaded = false
var banner_loaded = false

var score = 0

var load_data = load_play_data("user://play.data")

var window_size = OS.get_window_size()

var ball_speed = 50
var max_obstacles = 6
var min_obstacles = 3

func _ready():
	print("GyroRun: Let's Play!")
	if OS.get_name() == "Android":
		global.firebase.initWithFile("res://godot-firebase-config.json", get_instance_id())

	if load_data == null:
		load_data = {"Scores" : []}
	print("GyroRun: Data loaded " + String(load_data))
		
func _process(delta):
	if (time_to_next_ad > 0):
		time_to_next_ad = time_to_next_ad - delta
	else:
		ad_to_be_shown = true
	
func _receive_message(tag, from, key, data):
    print("GyroRun: Message received")
    print("GyroRun: TAG: " + tag + " From: ", from, " Key: ", key, " Data: ", data)
    if from == "AdMob":
        if key == "AdMobReward":
            # when rewared video play complete
            print("json data with [RewardType & RewardAmount]: ", data);

        elif key == "AdMob_Video":
            # when rewarded video loaded
            # data will be `loaded` or `load_failed and `loaded` or `not_loaded` with `firebase.request_rewarded_video_status()`
            print("AdMob rewarded video status is ", data);

        elif key == "AdMob_Banner":
            # when banner loaded
            # data will be `loaded` or `load_failed`
            print("GyroRun: Banner Status: ", data);
            banner_loaded = data == "loaded"
            if banner_loaded:
            	global.firebase.show_banner_ad(true)

        elif key == "AdMob_Interstitial" and data == "loaded":
            # when Interstitial loaded
            # data will be `loaded` or `load_failed`
            print("GyroRun: Interstitial Status: ", data);
            interstitial_loaded = data == "loaded"

func save_play_data(path, data):
    print("GyroRun: Data saving " + String(data))
    var f = File.new()
    f.open(path, File.WRITE)
    f.store_var(data)
    f.close()

func load_play_data(path):
    var f = File.new()
    if f.file_exists(path):
        f.open(path, File.READ)
        var data = f.get_var()
        f.close()
        return data
    return null

func score_is_high(score):
	var low = score
	for score in load_data["Scores"]:
		low = min(float(low), float(score["Score"]))
	if low == score:
		return false
	else:
		for i in range(load_data["Scores"].size()):
			if load_data["Scores"][i] == low:
				load_data["Scores"].remove(i)
				return true
		return true
	
func add_high_score(score, name):
	load_data["Scores"].push_back({"Name" : name, "Score" : score})
	save_play_data("user://play.data", load_data)