extends Label

@onready var score: Label = $"."

func _ready():
	update_score()  # Set initial score display
	GlobalScore.score_updated.connect(update_score)  # Listen for score changes

func update_score():
	text = "Score: " + str(GlobalScore.score)
	
