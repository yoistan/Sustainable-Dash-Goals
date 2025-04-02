extends CanvasLayer

func _ready():
	Global.touch_controls = self
	if Global.player.can_move:
		show()
	else:
		hide()

func show_interact_button():
	$interact.show()

func hide_interact_button():
	$interact.hide()
	
# change these to enter button
func show_enter_button():
	$interact.show()

func hide_enter_button():
	$interact.hide()
