extends Sprite

func _ready():
	pass

func _on_StartButton_pressed():
	if global.interstitial_loaded:
		global.firebase.show_banner_ad(false)
		global.firebase.show_interstitial_ad()
		global.time_to_next_ad = global.time_between_ads
	get_tree().change_scene("res://BallRoll.tscn")

