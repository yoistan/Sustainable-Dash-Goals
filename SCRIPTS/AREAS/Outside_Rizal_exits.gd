#### Outside_Rizal_exits.gd

extends StaticBody2D

func _on_next_scene_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://SCENES/AREAS/area_2_Rizal_Lobby.tscn")
