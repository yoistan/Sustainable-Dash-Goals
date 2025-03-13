extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "interact"

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		# sort all the active areas in the scene the player is in so the first one 
		# (the closest one to the player) will be interacted with
		active_areas.sort_custom(_sort_by_distance_to_player)
		# set the position of the label
		label.text = base_text
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

# return the interactable that is closest to the player
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		# make sure the player is indeed inside the interactable's range
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			# let the player interact with it
			print("awaiting now")
			await active_areas[0].interact.call()
			
			print("await finished")
			can_interact = true
