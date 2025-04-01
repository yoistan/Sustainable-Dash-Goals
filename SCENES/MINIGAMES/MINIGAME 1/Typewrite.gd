extends AnimationPlayer

@onready var writing_sfx = $"../WritingSfx"


func _ready() -> void:
	play("Intructions")

func _play_writing_sfx():
	writing_sfx.pitch_scale = randf_range(0.8, 1.2)
	writing_sfx.play()

func _on_animation_finished(_anim_name):
	writing_sfx.stop()
