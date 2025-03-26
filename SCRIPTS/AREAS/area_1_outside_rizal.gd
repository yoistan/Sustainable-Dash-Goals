### area_1_Outside_rizal.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()

func _ready():
	$InGame/Dash.add_child(player_camera)
	Audio.stop_music1()
	Audio.stop_area_2_music()
	Audio.play_music2()
