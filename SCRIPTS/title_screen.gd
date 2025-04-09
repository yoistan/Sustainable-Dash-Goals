extends Node

func _ready() -> void:
	$SceneTransition.fade_in()
	Audio.play_music1()
	Audio.stop_music2()

func _on_play_button_pressed():
	Audio.button_click()
	Audio.stop_music1()
	if Global.first_play:
		$SceneTransition.fade_out_and_switch_to("res://SCENES/CUTSCENES/introduction_cutscene.tscn")
	else:
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_1_Outside_Rizal.tscn")

func _on_settings_button_pressed():
	Audio.button_click()
	var settings_scene = preload("res://SCENES/settings.tscn").instantiate()
	add_child(settings_scene)  # Open settings menu as a child

func _on_quit_button_pressed():
	Audio.button_click()
	get_tree().quit()


func _on_meet_the_developers_pressed():
	Audio.button_click()
	$MeetTheDevelopers.show()
