### player_movement.gd

extends CharacterBody2D

@onready var ray_cast_2d = $RayCast2D
@onready var player_animation = $AnimationPlayer
@onready var step_sfx = $StepSfx
@onready var rigging = $rigging

var can_move : bool = true

const SPEED = 90.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.player = self

func _process(delta): # hides and unhides the button to interact if there is an interactable object in front of the player
	Global.touch_controls.hide_interact_button() # by default
	var target = ray_cast_2d.get_collider()
	if target != null: # if there is a target 
		if Global.touch_controls != null:
			if target.is_in_group("npc"):
				Global.touch_controls.show_interact_button()
			elif target.is_in_group("room"):
				Global.touch_controls.show_enter_button()
	else: # if there is none
		Global.touch_controls.hide_interact_button()
		Global.touch_controls.hide_enter_button()

func _physics_process(delta):
	# if player is not in a cutscene, let the player move.
	if can_move:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("move_left", "move_right")
		
		# Apply movement
		if direction == 1: # to the right
			player_animation.play("WALK")
			velocity.x = direction * SPEED
			rigging.scale.x = 1
		elif direction == -1: # to the left
			player_animation.play("WALK")
			velocity.x = direction * SPEED
			rigging.scale.x = -1
		else:
			player_animation.play("IDLE")
			step_sfx.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
			
		if velocity != Vector2.ZERO:
			ray_cast_2d.target_position = velocity.normalized() * 50

		move_and_slide()

func _input(event):
	# when the player interacts with an NPC
	if can_move:
		if event.is_action_pressed("interact"):
			var target = ray_cast_2d.get_collider()
			if target != null:
				if target.is_in_group("npc"):
					can_move = false
					set_player_last_location()
					target.start_dialogue()

func _play_step_audio():
	step_sfx.pitch_scale = randf_range(0.8, 1.2)
	step_sfx.play()

func set_player_last_location():
	match Global.current_scene:
		Global.area_1_name:
			Global.area_1_players_last_location = position
		Global.area_2_name:
			Global.area_2_players_last_location = position
		Global.area_2_hallway_name:
			Global.area_2_hallway_players_last_location = position
