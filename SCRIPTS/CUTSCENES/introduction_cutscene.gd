extends Node2D

func _ready():
	# transition
	Audio.play_music2()
	$SceneTransition.fade_in()
	
	$Whizzy.start_dialogue()

	
