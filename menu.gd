extends CanvasLayer

@onready var pause_menu = $Control  # Adjust path if needed

func _ready():
	pause_menu.visible = false 
	process_mode = Node.PROCESS_MODE_ALWAYS  # Ensure input works even when paused

func _input(event):
	if event.is_action_pressed("pause"):  # Pressing ESC (default)
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused  # Pause or unpause the game
	pause_menu.visible = get_tree().paused  # Show menu only when paused

func _on_resume_pressed():
	toggle_pause()

func _on_settings_button_pressed():
	# Open settings and ensure it knows it came from Pause Menu
	var settings_scene = load("res://SCENES/settings.tscn").instantiate()
	if settings_scene:
		settings_scene.set_is_game_paused(false)  # Tell Settings it came from Pause
		add_child(settings_scene)  # Open Settings as a child
		pause_menu.visible = false  # Hide Pause Menu, but keep the game paused
	else:
		print("Error: settings.tscn failed to load.")




func _on_main_menu_pressed():
	toggle_pause()
	get_tree().change_scene_to_file("res://SCENES/main.tscn")
