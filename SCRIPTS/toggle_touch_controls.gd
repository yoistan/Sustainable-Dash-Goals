extends CanvasLayer

const ENTER_NORMAL = preload("res://ASSETS/TOUCH CONTROLS BUTTONS/enter-normal.png")
const ENTER_PRESSED = preload("res://ASSETS/TOUCH CONTROLS BUTTONS/enter-pressed.png")

const TALK_NORMAL = preload("res://ASSETS/TOUCH CONTROLS BUTTONS/talk-normal.png")
const TALK_PRESSED = preload("res://ASSETS/TOUCH CONTROLS BUTTONS/talk-pressed.png")

func _ready():
	Global.touch_controls = self
	if Global.player.can_move:
		show()
	else:
		hide()

func show_interact_button():
	$interact.texture_normal = TALK_NORMAL
	$interact.texture_pressed = TALK_PRESSED
	$interact.show()

# change these to enter button
func show_enter_button():
	$interact.texture_normal = ENTER_NORMAL
	$interact.texture_pressed = ENTER_PRESSED
	$interact.show()

func hide_interaction_button():
	$interact.hide()
	
