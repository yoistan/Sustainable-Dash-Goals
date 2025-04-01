extends Node

var score = 0
signal score_updated  # Signal to notify the label

func add_score():
	score += 1
	print("Correct! Score: ", score)
	score_updated.emit()  # Notify label to update

	if score >= 5:
		print("You win!")
		go_to_next_scene()  # Call function to change scene

func go_to_next_scene():
	await get_tree().create_timer(1.0).timeout  # Optional delay before scene change
	get_tree().change_scene_to_file("res://SCENES/MINIGAMES/MINIGAME 1/congratulations_message.tscn")  # Change scene
