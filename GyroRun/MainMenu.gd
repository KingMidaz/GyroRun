extends Sprite

var firebase = Engine.get_singleton("FireBase");

func _ready():
	print("GyroRun: Let's Play!")
	if OS.get_name() == "Android":
        pass
		#firebase.initWithFile("res://godot-firebase-config.json", get_instance_id())

func _on_StartButton_pressed():
	get_tree().change_scene("res://BallRoll.tscn")
	pass

func _receive_message(tag, from, key, data):
    if tag == "FireBase":
        print("From: ", from, " Key: ", key, " Data: ", data)