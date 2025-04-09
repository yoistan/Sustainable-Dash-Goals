### area_2-1_Rizal_Hallway.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()
@onready var dash = $InGame/Dash

func _ready():
	var rooms = [
		Global.last_scene == Global.area_2_hallway_room_1,
		Global.last_scene == Global.area_2_hallway_room_2,
		Global.last_scene == Global.area_2_hallway_room_3,
		Global.last_scene == Global.area_2_hallway_room_4
	]
	
	Global.current_scene = Global.area_2_hallway_name
	for room in rooms:
		if room:
			dash.position = Global.area_2_hallway_players_last_location
	
	$InGame/Dash.add_child(player_camera)
