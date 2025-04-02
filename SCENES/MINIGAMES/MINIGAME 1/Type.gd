extends AnimationPlayer

func _ready() -> void:
	play("Type")
	connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Type":  # Make sure it's the correct animation
		### SCRAPPING ACHIEVEMENTS SCREEN: get_tree().change_scene_to_file("res://SCENES/Achivement.tscn")  # Change to your scene 2 path
		$"../SceneTransition".fade_out_and_switch_to("res://SCENES/AREAS/area_1_Outside_Rizal.tscn")
