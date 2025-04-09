extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	hide()

func fade_in():
	show()
	animation_player.play("fade_in")

func fade_out():
	show()
	animation_player.play("fade_out")

func fade_out_and_switch_to(scene, sfx_type=""):
	show()
	animation_player.play("fade_out")
	await animation_player.animation_finished
	show()
	
	if sfx_type == "stairs":
		Audio.play_stairs_sfx()
		await Audio.walking_on_stairs.finished # stairs sfx
	
	get_tree().call_deferred("change_scene_to_file", scene)

func _on_animation_player_animation_finished(_anim_name):
	hide()
