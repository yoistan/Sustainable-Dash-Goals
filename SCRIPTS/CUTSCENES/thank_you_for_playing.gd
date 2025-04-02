extends CanvasLayer

func _on_button_pressed():
	Audio.button_click()
	queue_free()
