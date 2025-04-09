#### Outside_Rizal_exits.gd

extends StaticBody2D

const BG_RIZALOUTDOORS_2_NOBOXES = preload("res://ASSETS/BACKGROUNDS/bg_rizaloutdoors2_noboxes.png")

func _ready():
	if Global.minigame_1_done:
		$background.texture = BG_RIZALOUTDOORS_2_NOBOXES

func _on_next_scene_body_entered(body):
	if body.is_in_group("player"):
		Global.area_1_players_last_location = Global.player.position
		Global.last_scene = Global.area_1_name
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2_Rizal_Lobby.tscn", "stairs")
