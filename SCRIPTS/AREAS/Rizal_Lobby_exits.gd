### Rizal_Lobby_exits.gd

extends StaticBody2D

func _on_previous_scene_body_entered(body):
	if body.is_in_group("player"):
		Global.last_scene = Global.area_2_name
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_1_Outside_Rizal.tscn", "stairs")

func _on_next_scene_body_entered(body):
	if body.is_in_group("player"):
		Global.last_scene = Global.area_2_name
		Global.area_2_players_last_location = Vector2(body.position.x - 10, body.position.y)
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
