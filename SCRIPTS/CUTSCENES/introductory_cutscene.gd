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
