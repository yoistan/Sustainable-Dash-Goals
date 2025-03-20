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
	toggle_pause()
	get_tree().change_scene_to_file("res://SCENES/settings.tscn")

func _on_main_menu_pressed():
	toggle_pause()
	get_tree().change_scene_to_file("res://SCENES/main.tscn")
