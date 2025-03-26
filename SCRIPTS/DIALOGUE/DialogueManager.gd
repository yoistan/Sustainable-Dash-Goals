### DialogueManger.gd

extends Node2D

@onready var dialogue_ui = $DialogueUi

var npc : Node = null

# show dialogue with data
func show_dialogue(npc, text = "", options = {}):
	if text != "":
		# show empty box
		dialogue_ui.show_dialogue(npc.npc_name, text, options)
	else:
		# show populated data
		var dialogue = npc.get_current_dialogue()
		if dialogue == null:
			return
		dialogue_ui.show_dialogue(npc.npc_name, dialogue["text"], dialogue["options"])

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
		npc.set_dialogue_state("start")
		hide_dialogue()
		get_tree().change_scene_to_file("res://SCENES/MINIGAMES/MiniGame1/instructions_1.tscn")
	elif next_state == "START_MINIGAME_2":
		npc.set_dialogue_state("start")
		hide_dialogue()
		npc.set_dialogue_branch(npc.current_branch_index + 1) # move to ongoing quest branch
	else:
		show_dialogue(npc)
