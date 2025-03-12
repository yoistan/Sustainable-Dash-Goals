extends Control

func _ready() -> void:
	$Volume.value = db_to_linear(AudioServer.get_bus_volume_db(0))

func _on_check_box_toggled(toggled_on: bool):
	AudioServer.set_bus_mute(0,toggled_on)

func _on_quit_button_pressed() -> void:
	AudioServer.set_bus_volume_db(0, db_to_linear($Volume.value))
	get_tree().change_scene_to_file("res://SCENES/title_screen.tscn")
	

func _on_volume_mouse_exited() -> void:
	release_focus()
