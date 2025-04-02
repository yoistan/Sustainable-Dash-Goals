### area_2-1_Rizal_Hallway.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()
@onready var dash = $InGame/Dash

func _ready():
	Global.current_scene = Global.area_2_hallway_name
	$InGame/Dash.add_child(player_camera)
	
