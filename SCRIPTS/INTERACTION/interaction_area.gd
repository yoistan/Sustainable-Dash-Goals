extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

#!!
var temporary_scene_fix = preload("res://SCENES/MINIGAMES/MiniGame1/game_1_dia.tscn").instantiate()

var interact: Callable = func():
	get_tree().change_scene_to_file("res://SCENES/MINIGAMES/MiniGame1/game_1_dia.tscn")

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
