### gab.gd

extends CharacterBody2D

@onready var dialogue_manager = $DialogueManager

# NPC ID
var npc_id = "NPC_Gab"
var npc_name = "Gab"

@export var dialogue_resource: Dialogue
var current_state = "start"
var current_branch_index = 0

# branches
var start_quest_branch = 0
var ongoing_quest_branch = 1
var finishing_quest_branch = 2
var default_branch = 3

func _ready():
	# load dialogue data
	dialogue_resource.load_from_json("res://RESOURCES/DIALOGUE/dialogue_data.json")
	# initialize NPC reference
	dialogue_manager.npc = self

func _process(float) -> void:
	# checks the states of the branches
	if Global.minigame_2_started:
		current_branch_index = ongoing_quest_branch
	if Global.minigame_2_room_1_done and Global.minigame_2_room_2_done and Global.minigame_2_room_3_done and Global.minigame_2_room_4_done:
		current_branch_index = finishing_quest_branch
	if Global.minigame_2_done:
		current_branch_index = default_branch
		$QuestMarker.hide()

func start_dialogue():
	var npc_dialogues = dialogue_resource.get_npc_dialogue(npc_id)
	if npc_dialogues.is_empty():
		return
	dialogue_manager.show_dialogue(self)

func get_current_dialogue():
	var npc_dialogues = dialogue_resource.get_npc_dialogue(npc_id)
	if current_branch_index < npc_dialogues.size():
		for dialogue in npc_dialogues[current_branch_index]["dialogues"]:
			if dialogue["state"] == current_state:
				return dialogue
	return null

# update dialogue branch
func set_dialogue_branch(branch_index):
	current_branch_index = branch_index
	current_state = "start"

func set_dialogue_state(state):
	current_state = state
