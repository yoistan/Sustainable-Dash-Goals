### area_2_rizal_lobby.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()
@onready var dash = $InGame/Dash

func _ready():
	# set the player's position to be at the end of the map if they are from the hallway
	if Global.last_scene == Global.area_2_hallway_name:
		dash.position = Global.area_2_players_last_location
		dash.rigging.scale.x = -1
	
	Global.current_scene = Global.area_2_name
	
	$InGame/Dash.add_child(player_camera)
	Audio.stop_music2()
	Audio.play_area_2_music()
