### achivement.gd

extends Node2D

func _ready() -> void:
	Audio.stop_congrats()
	Audio.play_achieve()
	

func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://SCENES/AREAS/area_1_Outside_Rizal.tscn")


func _on_label_4_meta_clicked(meta):
	OS.shell_open(meta)
