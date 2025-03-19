extends Camera2D

@onready var blur = $blur

func _ready():
	blur.hide()

func _process(_delta):
	if !Global.player.can_move:
		blur.show()
	else:
		blur.hide()
