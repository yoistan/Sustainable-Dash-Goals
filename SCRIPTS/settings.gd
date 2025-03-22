extends Control

var is_game_paused: bool = false  # Track if opened from the Pause Menu

func _ready() -> void:
	# Get the current volume and set it to the slider
	var volume_db = AudioServer.get_bus_volume_db(0)
	$Volume.value = db_to_linear(volume_db)

	# Set mute checkbox state based on current mute status
	$CheckBox.button_pressed = AudioServer.is_bus_mute(0)

	# Ensure volume works even if paused
	process_mode = Node.PROCESS_MODE_ALWAYS  

	# Connect slider signal
	$Volume.connect("value_changed", Callable(self, "_on_volume_value_changed"))

# Call this function before opening settings to track if it’s from the Pause Menu
func set_is_game_paused(paused: bool) -> void:
	is_game_paused = paused

func _on_check_box_toggled(toggled_on: bool):
	AudioServer.set_bus_mute(0, toggled_on)

# Handle Back button (returns to Pause Menu if applicable)
func _on_quit_button_pressed() -> void:
	if is_game_paused:
		# Show Pause Menu again instead of unpausing the game
		var pause_menu = preload("res://SCENES/menu.tscn").instantiate()
		get_parent().add_child(pause_menu)  
	else:
		# Only unpause the game if it wasn’t from the Pause Menu
		get_tree().paused = false  

	queue_free()  # Close the Settings Menu

func _on_volume_value_changed(value: float) -> void:
	# Convert linear value to decibels and set it
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(0, volume_db)

	# Uncheck mute button if volume is adjusted
	if AudioServer.is_bus_mute(0) and volume_db > -80.0:
		$CheckBox.button_pressed = false
		AudioServer.set_bus_mute(0, false)
