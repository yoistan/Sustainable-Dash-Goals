extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()

func _on_introductory_cutscene_cutscene_playing():
	$InGame.hide()
	$InGame/TouchControls.hide()
	
func _on_introductory_cutscene_cutscene_ended():
	$InGame.show()
	$InGame/TouchControls.show()
	$InGame/Dash.add_child(player_camera)
