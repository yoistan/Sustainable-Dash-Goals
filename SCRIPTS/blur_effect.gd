extends Camera2D

@onready var blur = $blur

func _ready():
	$ThankYouForPlaying.hide()
	$SceneTransition.fade_in()
	blur.hide()

func _process(_delta):
	if !Global.player.can_move:
		blur.show()
	else:
		blur.hide()
	
	if Global.game_completed:
		$ThankYouForPlaying.show()
		Global.game_completed = false
