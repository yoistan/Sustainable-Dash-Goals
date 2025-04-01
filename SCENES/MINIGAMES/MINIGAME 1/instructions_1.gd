extends Node2D


func _on_button_pressed() -> void:
	Audio.button_click()
	get_tree().change_scene_to_file("res://SCENES/MINIGAMES/minigame_1_segregation.tscn")
