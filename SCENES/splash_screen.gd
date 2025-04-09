extends Node2D


func _on_video_stream_player_finished():
	$SceneTransition.fade_out_and_switch_to("res://SCENES/title_screen.tscn")
