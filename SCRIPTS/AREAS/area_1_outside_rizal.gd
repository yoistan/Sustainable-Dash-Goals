### area_1_Outside_rizal.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()
@onready var dash = $InGame/Dash

func _ready():
	# set the current scene 
	Global.current_scene = Global.area_1_name
	
	# set the default position or the last saved location of dash 
	dash.position = Global.area_1_players_last_location
	
	# if dash's last location is area 2
	if dash.position != Global.default_spawn_area_1 and Global.last_scene == Global.area_2_name:
		dash.position.x -= 10 # push him back 10 pixels away from the area2d
		dash.rigging.scale.x = -1 # flip his sprite
	
	# add the player camera to dash
	$InGame/Dash.add_child(player_camera)
	
	# configure audio
	if not Audio.bg_2.is_playing():
		Audio.play_music2()
	Audio.stop_music1()
	Audio.stop_area_2_music()
	
