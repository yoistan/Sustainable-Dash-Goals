### player_movement.gd

extends CharacterBody2D

@onready var dash = $AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D
@onready var player_animation = $AnimationPlayer
@onready var touch_controls = $TouchControls

var can_move : bool = true

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.player = self

func _physics_process(delta):
	# if player is not in a cutscene, let the player move.
	if can_move:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("move_left", "move_right")
		
		# Apply movement
		if direction == 1:
			player_animation.play("WALK")
			velocity.x = direction * SPEED
			$rigging.scale.x = 1
		elif direction == -1:
			player_animation.play("WALK")
			velocity.x = direction * SPEED
			$rigging.scale.x = -1
		else:
			player_animation.play("IDLE")
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
					print("im talking to an npc")
					can_move = false
					target.start_dialogue()
