### DialogueManger.gd

extends Node2D

@onready var dialogue_ui = $DialogueUi

var npc : Node = null
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

	elif next_state == "TO_OUTSIDE_RIZAL":
		npc.set_dialogue_state("start")
		Global.first_play = false
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_1_Outside_Rizal.tscn")

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
		Global.minigame_2_started = true # move to "ongoing quest" quest branch
	
	elif next_state == "GO_OUT_ROOM_1":
		next_state_after_animation = next_state
		npc.set_dialogue_state("start")
		Global.last_scene = Global.area_2_hallway_room_1
		dialogue_ui.ui.visible = false
		Audio.stop_minigame_2_music()
		if !Audio.area_2_music.is_playing():
			Audio.play_area_2_music()
		Global.minigame_2_room_1_done = true
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
		
	elif next_state == "GO_OUT_ROOM_2":
		next_state_after_animation = next_state
		npc.set_dialogue_state("start")
		Global.last_scene = Global.area_2_hallway_room_2
		dialogue_ui.ui.visible = false
		Audio.stop_minigame_2_music()
		if !Audio.area_2_music.is_playing():
			Audio.play_area_2_music()
		Global.minigame_2_room_2_done = true
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
		
	elif next_state == "GO_OUT_ROOM_3":
		next_state_after_animation = next_state
		npc.set_dialogue_state("start")
		Global.last_scene = Global.area_2_hallway_room_3
		dialogue_ui.ui.visible = false
		Audio.stop_minigame_2_music()
		if !Audio.area_2_music.is_playing():
			Audio.play_area_2_music()
		Global.minigame_2_room_3_done = true
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")
		
	elif next_state == "GO_OUT_ROOM_4":
		next_state_after_animation = next_state
		npc.set_dialogue_state("start")
		Global.last_scene = Global.area_2_hallway_room_4
		dialogue_ui.ui.visible = false
		Audio.stop_minigame_2_music()
		if !Audio.area_2_music.is_playing():
			Audio.play_area_2_music()
		Global.minigame_2_room_4_done = true
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2-1_Rizal_Hallway.tscn")

	elif next_state == "FLASH_RECITATION_START":
		Audio.stop_area_2_music()
		Audio.play_minigame_2_music()
		
		# set the dialogue state depending on the branch
		if npc.current_branch_index != 0: # if it is a returning player
			npc.set_dialogue_state("start_recitation")
		else: # if it is the first time
			npc.set_dialogue_state("what_if_wrong")
		
		show_dialogue(npc)
	
	# MINIGAME 2 ROOM 1 SCORING
	elif next_state == "1_Q1_correct":
		Global.minigame_2_room_1_score += 1
		npc.set_dialogue_state("1_Q1_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_1_score)
		
	elif next_state == "1_Q2_correct":
		Global.minigame_2_room_1_score += 1
		npc.set_dialogue_state("1_Q2_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_1_score)
		
	elif next_state == "1_Q3_correct":
		Global.minigame_2_room_1_score += 1
		npc.set_dialogue_state("1_Q3_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_1_score)
		
	elif next_state == "SCORE_REVEAL":
		match Global.minigame_2_room_1_score:
			0:
				npc.set_dialogue_state("score_0")
				show_dialogue(npc)
			1:
				npc.set_dialogue_state("score_1")
				show_dialogue(npc)
			2:
				npc.set_dialogue_state("score_2")
				show_dialogue(npc)
			3:
				npc.set_dialogue_state("score_3")
				show_dialogue(npc)
		Global.minigame_2_room_1_score = 0
	
	# MINIGAME 2 ROOM 2 SCORING
	elif next_state == "2_Q1_correct":
		Global.minigame_2_room_2_score += 1
		npc.set_dialogue_state("2_Q1_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_2_score)
		
	elif next_state == "2_Q2_correct":
		Global.minigame_2_room_2_score += 1
		npc.set_dialogue_state("2_Q2_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_2_score)
		
	elif next_state == "2_Q3_correct":
		Global.minigame_2_room_2_score += 1
		npc.set_dialogue_state("2_Q3_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_2_score)
		
	elif next_state == "R2_SCORE_REVEAL":
		match Global.minigame_2_room_2_score:
			0:
				npc.set_dialogue_state("score_0")
				show_dialogue(npc)
			1:
				npc.set_dialogue_state("score_1")
				show_dialogue(npc)
			2:
				npc.set_dialogue_state("score_2")
				show_dialogue(npc)
			3:
				npc.set_dialogue_state("score_3")
				show_dialogue(npc)
		Global.minigame_2_room_2_score = 0
	
	# MINIGAME 2 ROOM 3 SCORING
	elif next_state == "3_Q1_correct":
		Global.minigame_2_room_3_score += 1
		npc.set_dialogue_state("3_Q1_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_3_score)
		
	elif next_state == "3_Q2_correct":
		Global.minigame_2_room_3_score += 1
		npc.set_dialogue_state("3_Q2_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_3_score)
		
	elif next_state == "3_Q3_correct":
		Global.minigame_2_room_3_score += 1
		npc.set_dialogue_state("3_Q3_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_3_score)
		
	elif next_state == "R3_SCORE_REVEAL":
		match Global.minigame_2_room_3_score:
			0:
				npc.set_dialogue_state("score_0")
				show_dialogue(npc)
			1:
				npc.set_dialogue_state("score_1")
				show_dialogue(npc)
			2:
				npc.set_dialogue_state("score_2")
				show_dialogue(npc)
			3:
				npc.set_dialogue_state("score_3")
				show_dialogue(npc)
		Global.minigame_2_room_3_score = 0
	
	# MINIGAME 2 ROOM 3 SCORING
	elif next_state == "4_Q1_correct":
		Global.minigame_2_room_4_score += 1
		npc.set_dialogue_state("4_Q1_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_4_score)
		
	elif next_state == "4_Q2_correct":
		Global.minigame_2_room_4_score += 1
		npc.set_dialogue_state("4_Q2_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_4_score)
		
	elif next_state == "4_Q3_correct":
		Global.minigame_2_room_4_score += 1
		npc.set_dialogue_state("4_Q3_correct")
		show_dialogue(npc)
		print(Global.minigame_2_room_4_score)
		
	elif next_state == "R4_SCORE_REVEAL":
		match Global.minigame_2_room_4_score:
			0:
				npc.set_dialogue_state("score_0")
				show_dialogue(npc)
			1:
				npc.set_dialogue_state("score_1")
				show_dialogue(npc)
			2:
				npc.set_dialogue_state("score_2")
				show_dialogue(npc)
			3:
				npc.set_dialogue_state("score_3")
				show_dialogue(npc)
		Global.minigame_2_room_4_score = 0
	
	elif next_state == "FINISH_MINIGAME_2": 
		Global.minigame_2_done = true
		npc.set_dialogue_state("start")
		hide_dialogue()
	
	## ABOUT THE SDGS
	elif next_state == "ABOUT_SDG_13":
		Global.sdg_to_discuss = 13
		$SceneTransition.fade_out_and_switch_to("res://SCENES/CUTSCENES/Whizzy_SDG_cutscene.tscn")
	elif next_state == "VISIT_SDG_13_PAGE":
		OS.shell_open("https://www.globalgoals.org/goals/13-climate-action/")
		npc.set_dialogue_state("learn_more")
		show_dialogue(npc)
	elif next_state == "SDG_13_EXPLANATION_END":
		Global.sdg_to_discuss = 0
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_1_Outside_Rizal.tscn")
	
	elif next_state == "ABOUT_SDG_4":
		Global.sdg_to_discuss = 4
		$SceneTransition.fade_out_and_switch_to("res://SCENES/CUTSCENES/Whizzy_SDG_cutscene.tscn")
	elif next_state == "VISIT_SDG_4_PAGE":
		OS.shell_open("https://www.globalgoals.org/goals/4-quality-education/")
		npc.set_dialogue_state("learn_more")
		show_dialogue(npc)
	elif next_state == "SDG_4_END":
		Global.sdg_to_discuss = 0
		$SceneTransition.fade_out_and_switch_to("res://SCENES/AREAS/area_2_Rizal_Lobby.tscn")
		Global.game_completed = true
	else:
		show_dialogue(npc)
	
	print(next_state)
