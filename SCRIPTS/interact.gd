extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
var lauraCutscene = load("res://SCENES/MINIGAMES/MiniGame1/game_1_dia.tscn")

func _ready():
	$InteractionArea.interact = Callable(self, "_on_interact")

func _on_interact():
	print("interacted")
	#get_parent().change_scene_to_file("res://SCENES/MINIGAMES/MiniGame1/game_1_dia.tscn")
