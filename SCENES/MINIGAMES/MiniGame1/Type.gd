extends AnimationPlayer

func _ready() -> void:
	play("Type")
	connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Type":  # Make sure it's the correct animation
		get_tree().change_scene_to_file("res://SCENES/Achivement.tscn")  # Change to your scene 2 path
