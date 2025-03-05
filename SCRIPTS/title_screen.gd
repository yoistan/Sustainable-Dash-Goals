extends Node

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://SCENES/CUTSCENES/introductory_cutscene.tscn")

func _on_settings_button_pressed():
	pass # insert here settings screen scene

func _on_quit_button_pressed():
	get_tree().quit()
