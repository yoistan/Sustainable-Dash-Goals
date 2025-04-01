### area_2_rizal_lobby.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()

func _ready():
	Global.current_scene = Global.area_2_name
	
	$InGame/Dash.add_child(player_camera)
	Audio.stop_music2()
	Audio.play_area_2_music()
