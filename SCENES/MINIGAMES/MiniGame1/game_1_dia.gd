extends Node2D

@onready var animation = $AnimationPlayer
signal cutscene_playing
signal cutscene_ended

func _ready():
	cutscene_playing.emit()
	animation.play("introductory_cutscene")

func _on_dialogue_box_dialogue_queue_finished():
	animation.play("fade_out")
	cutscene_ended.emit()
	queue_free()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/MINIGAMES/minigame_1_segregation.tscn")
