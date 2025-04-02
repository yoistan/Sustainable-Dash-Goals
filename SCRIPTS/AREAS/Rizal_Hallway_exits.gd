### Rizal_Hallway_exits.gd

extends StaticBody2D

var rizal_room : int
var label_parents = []

func _input(event):
	if event.is_action_pressed("interact"): 
		match rizal_room:
			308:
				get_tree().change_scene_to_file("res://SCENES/AREAS/area_2-1_room_1.tscn")
			306:
				get_tree().change_scene_to_file("res://SCENES/AREAS/area_2-1_room_2.tscn")
			304:
				get_tree().change_scene_to_file("res://SCENES/AREAS/area_2-1_room_3.tscn")
			302:
				get_tree().change_scene_to_file("res://SCENES/AREAS/area_2-1_room_4.tscn")

# ENTERS

func _on_enter_room_1_body_entered(_body):
	rizal_room = 308
	add_label($ROOM_1/enter_room_1/CollisionShape2D)
	add_label($ROOM_1/enter_room_1/CollisionShape2D2)

func _on_enter_room_2_body_entered(_body):
	rizal_room = 306
	add_label($ROOM_2/enter_room_2/CollisionShape2D)
	add_label($ROOM_2/enter_room_2/CollisionShape2D2)

func _on_enter_room_3_body_entered(_body):
	rizal_room = 304
	add_label($ROOM_3/enter_room_3/CollisionShape2D)
	add_label($ROOM_3/enter_room_3/CollisionShape2D2)

func _on_enter_room_4_body_entered(_body):
	rizal_room = 302
	add_label($ROOM_4/enter_room_4/CollisionShape2D)
	add_label($ROOM_4/enter_room_4/CollisionShape2D2)

# EXITS

func _on_enter_room_1_body_exited(_body):
	rizal_room = 0
	remove_label()

func _on_enter_room_2_body_exited(_body):
	rizal_room = 0
	remove_label()

func _on_enter_room_3_body_exited(_body):
	rizal_room = 0
	remove_label()

func _on_enter_room_4_body_exited(_body):
	rizal_room = 0
	remove_label()

# add label to the door the player wants to enter
func add_label(parent):
	var label = Label.new()
	const DIALOGUE_TEXT_THEME = preload("res://THEMES/dialogue text theme.tres")
	
	# customizing the label
	label.text = "Enter R" + str(rizal_room)
	label.set_theme(DIALOGUE_TEXT_THEME)
	label.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	label.add_theme_color_override("font_color", Color.BLACK)
	label.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	label.set_position(Vector2(-10, -30.0))
	
	label_parents.append(parent)
	parent.add_child(label)

# remove the labels when the player exits the door area
func remove_label():
	for parent in label_parents:
		for child in parent.get_children():
			parent.remove_child(child)
			child.queue_free()
		
	label_parents.clear()
