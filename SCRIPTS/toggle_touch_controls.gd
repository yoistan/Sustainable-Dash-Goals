extends CanvasLayer

func _ready():
	if Global.player.can_move:
		show()
	else:
		hide()
