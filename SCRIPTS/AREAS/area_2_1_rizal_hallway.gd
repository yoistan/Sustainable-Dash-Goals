### area_2-1_Rizal_Hallway.gd

extends Node2D

@onready var player_camera = load("res://SCENES/CHARACTERS/player_camera.tscn").instantiate()

func _ready():
	Global.current_scene = Global.area_2_hallway_name
	$InGame/Dash.add_child(player_camera)
	

func _on_go_back_body_entered(_body):
	$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2_Rizal_Lobby.tscn")
