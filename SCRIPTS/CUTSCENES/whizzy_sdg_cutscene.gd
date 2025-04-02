### whizzy_sdg_cutscene.gd

extends Node2D

@onready var sdg_4 = $sdg4
@onready var sdg_13 = $sdg13
@onready var whizzy = $Whizzy

func _ready():
	# transition
	$SceneTransition.fade_in()
	
	# hide sprites by default
	sdg_4.hide()
	sdg_13.hide()
	
	if Global.sdg_to_discuss == 4:
		sdg_4.show()
	elif Global.sdg_to_discuss == 13:
		sdg_13.show()
	
	whizzy.start_dialogue()

	
