### DialogueManger.gd

extends Node2D

@onready var dialogue_ui = $DialogueUi

var npc : Node = null
var minigame_1_done = false
var minigame_2_done = false
var next_state_after_animation

func _ready():
	$SceneTransition.hide()

# show dialogue with data
func show_dialogue(npc, speaking = "", text = "", options = {}):
	if text != "":
		# show empty box
		dialogue_ui.show_dialogue(npc.npc_name, speaking, text, options)
	else:
		# show populated data
		var dialogue = npc.get_current_dialogue()
		if dialogue == null:
			return
		dialogue_ui.show_dialogue(npc.npc_name, dialogue["speaking"], dialogue["text"], dialogue["options"])

func hide_dialogue():
	dialogue_ui.hide_dialogue()
	
# Dialogue state manager
func handle_dialogue_option(option):
	# get the current dialogue branch
	var current_dialogue = npc.get_current_dialogue()
	if current_dialogue == null:
		return
	# update the state
	var next_state = current_dialogue["options"].get(option, "start")
	npc.set_dialogue_state(next_state)
	
	# handle state transition
	if next_state == "end":
		if npc.current_branch_index < npc.dialogue_resource.get_npc_dialogue(npc.npc_id).size() - 1:
			npc.set_dialogue_branch(npc.current_branch_index + 1)
		hide_dialogue()
	elif next_state == "exit":
		npc.set_dialogue_state("start")
		hide_dialogue()
	elif next_state == "START_MINIGAME_1":
		next_state_after_animation = next_state
		npc.set_dialogue_state("start")
		hide_dialogue()
		Global.last_scene = Global.area_1_name
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to default branch
		$SceneTransition.fade_out_and_switch_to("res://SCENES/MINIGAMES/MINIGAME 1/instructions_1.tscn")
	elif next_state == "START_MINIGAME_2":
		npc.set_dialogue_state("start")
		hide_dialogue()
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to ongoing quest branch
	elif next_state == "go_out_room_1":
		next_state_after_animation = next_state
		npc.set_dialogue_state("start")
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to ongoing quest branch
		Global.last_scene = Global.area_2_hallway_room_1
		dialogue_ui.ui.visible = false
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
	elif next_state == "go_out_room_2":
		npc.set_dialogue_state("start")
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to ongoing quest branch
		Global.last_scene = Global.area_2_hallway_room_2
		get_tree().call_deferred("change_scene_to_file", "res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
		dialogue_ui.ui.visible = false
	elif next_state == "go_out_room_3":
		npc.set_dialogue_state("start")
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to ongoing quest branch
		Global.last_scene = Global.area_2_hallway_room_3
		get_tree().call_deferred("change_scene_to_file", "res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
		dialogue_ui.ui.visible = false
	elif next_state == "go_out_room_4":
		npc.set_dialogue_state("start")
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to ongoing quest branch
		Global.last_scene = Global.area_2_hallway_room_4
		get_tree().call_deferred("change_scene_to_file", "res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
		dialogue_ui.ui.visible = false
	else:
		show_dialogue(npc)
