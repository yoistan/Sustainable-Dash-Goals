extends CharacterBody2D

@onready var dash = $AnimatedSprite2D

var isPlayerInCutscene : bool = false

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# if player is not in a cutscene, let the player move.
	if !isPlayerInCutscene:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("move_left", "move_right")
		
		# Apply movement
		if direction:
			dash.play("running")
			velocity.x = direction * SPEED
		else:
			dash.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if direction != 0:
			dash.flip_h = (direction == -1)

		move_and_slide()


func _on_introductory_cutscene_tree_entered():
	isPlayerInCutscene = true

func _on_introductory_cutscene_tree_exited():
	isPlayerInCutscene = false
