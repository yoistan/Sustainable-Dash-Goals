extends Panel

@export var sdg : int

const SDG_13_QUEST = preload("res://THEMES/SDG_13_quest.tres")
const SDG_4_QUEST = preload("res://THEMES/SDG_4_quest.tres")

func _ready():
	$AnimationPlayer.play("bop")
	match sdg:
		13:
			add_theme_stylebox_override("panel", SDG_13_QUEST)
		4:
			add_theme_stylebox_override("panel", SDG_4_QUEST)
