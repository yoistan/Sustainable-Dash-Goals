#### Outside_Rizal_exits.gd

extends StaticBody2D

@onready var dash = $"../Dash"

func _on_next_scene_body_entered(body):
	if body.is_in_group("player"):
		Global.area_1_players_last_location = dash.position
		Global.last_scene = Global.area_1_name
		get_tree().call_deferred("change_scene_to_file", "res://SCENES/AREAS/area_2_Rizal_Lobby.tscn")
