### area_introduction.gd

extends CanvasLayer

func _ready():
	hide()
	if Global.area_2_lobby_is_new and get_parent().name == "Area2RizalLobby":
		show()
		$Panel/Label.text = "Rizal 3rd Floor Lobby"
		$AnimationPlayer.play("area_intro")
		Global.area_2_lobby_is_new = false
	if Global.area_2_hallway_is_new and get_parent().name == "Area2-1RizalHallway":
		show()
		$Panel/Label.text = "Rizal 3rd Floor Hallway"
		$AnimationPlayer.play("area_intro")
		Global.area_2_hallway_is_new = false
