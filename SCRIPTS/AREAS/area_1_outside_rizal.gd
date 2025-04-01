### area_1_Outside_rizal.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()
@onready var dash = $InGame/Dash

func _ready():
	Global.current_scene = Global.area_1_name
	
	dash.position = Global.area_1_players_last_location
	
	if dash.position != Global.default_spawn_area_1 and Global.last_scene == Global.area_2_name: # if dash's last location is area 2
		dash.position.x -= 10
		dash.rigging.scale.x = -1
	
	$InGame/Dash.add_child(player_camera)
	Audio.stop_music1()
	Audio.stop_area_2_music()
	Audio.play_music2()
