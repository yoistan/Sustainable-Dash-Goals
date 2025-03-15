extends Node

var score = 0
signal score_updated  # Signal to notify the label

func add_score():
	score += 1
	print("Correct! Score: ", score)
	score_updated.emit()  # Notify label to update

	if score >= 5:
		print("You win!")  # Replace this with a win screen or effect
