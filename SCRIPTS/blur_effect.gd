extends Camera2D

@onready var blur = $blur

func _ready():
	$SceneTransition.fade_in()
	blur.hide()

func _process(_delta):
	if !Global.player.can_move:
		blur.show()
	else:
		blur.hide()
