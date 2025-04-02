extends Area2D

@onready var info = $"../../Info1"
@onready var anim_player = $"../../AnimationPlayer"
@onready var collision = $CollisionShape2D
@onready var dialogue_box: Sprite2D = $"../../Info1/DialogueBox"

var is_info_visible = false  # Track visibility state
var can_click = false  # Start with clicking disabled

func _ready():
	collision.set_deferred("disabled", true)  # Disable collision initially
	anim_player.play("SDG 13")  # Play intro animation
	dialogue_box.hide()
	await anim_player.animation_finished  # Wait for animation to finish
	collision.set_deferred("disabled", false)  # Enable clicking after animation
	can_click = true  # Allow clicking

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and can_click:
		can_click = false  # Temporarily disable clicking

		if not is_info_visible:
			dialogue_box.show()
			info.visible = true
			anim_player.play("Show")
			await anim_player.animation_finished  # Wait until the "Show" animation finishes
		else:
			anim_player.play("Hide")
			await anim_player.animation_finished  # Wait until the "Hide" animation finishes
			info.visible = false
			dialogue_box.hide()

		is_info_visible = !is_info_visible  # Toggle state **after** animation completes

		await get_tree().create_timer(0.1).timeout  # Small delay to prevent accidental rapid clicks
		can_click = true  # Re-enable clicking after the animation fully completes
