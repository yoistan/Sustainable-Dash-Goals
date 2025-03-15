extends Control

func _ready() -> void:
	# Get the current volume and set it to the slider
	var volume_db = AudioServer.get_bus_volume_db(0)
	$Volume.value = db_to_linear(volume_db)
	
	# Set mute checkbox state based on current mute status
	$CheckBox.button_pressed = AudioServer.is_bus_mute(0)

	# Connect slider signal
	$Volume.connect("value_changed", Callable(self, "_on_volume_value_changed"))

func _on_check_box_toggled(toggled_on: bool):
	AudioServer.set_bus_mute(0, toggled_on)

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/title_screen.tscn")

func _on_volume_value_changed(value: float) -> void:
	# Convert linear value to decibels and set it
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(0, volume_db)
	
	# Uncheck the mute button if the user adjusts the volume
	if AudioServer.is_bus_mute(0) and volume_db > -80.0:
		$CheckBox.button_pressed = false
		AudioServer.set_bus_mute(0, false)

func _on_volume_mouse_exited() -> void:
	release_focus()
