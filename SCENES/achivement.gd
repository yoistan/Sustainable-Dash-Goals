extends Node2D

func _ready() -> void:
	Audio.stop_congrats()
	Audio.play_achieve()
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/AREAS/area_2_Rizal_Lobby.tscn")
