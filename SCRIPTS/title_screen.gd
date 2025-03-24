extends Node

func _ready() -> void:
	Audio.play_music1()
	Audio.stop_music2()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://SCENES/AREAS/area_1_Outside_Rizal.tscn")

func _on_settings_button_pressed():
	var settings_scene = preload("res://SCENES/settings.tscn").instantiate()
	add_child(settings_scene)  # Open settings menu as a child

func _on_quit_button_pressed():
	get_tree().quit()
