### dialogue_ui.gd

extends Control

@onready var ui = $CanvasLayer
@onready var speaker_name = $CanvasLayer/TextBoxContainer/speaker/SpeakerName
@onready var dialogue_text = $CanvasLayer/TextBoxContainer/text/DialogueText
@onready var dialogue_options = $CanvasLayer/TextBoxContainer/options/dialogueOptions
@onready var npc_sprite = $CanvasLayer/TextBoxContainer/NPC
@onready var dash_sprite = $CanvasLayer/TextBoxContainer/DASH


# sprites
const LAURA = preload("res://ASSETS/CHARACTERS/NPCS/Laura.png")
const GAB = preload("res://ASSETS/CHARACTERS/NPCS/Gab.png")
const GABRIEL = preload("res://ASSETS/CHARACTERS/NPCS/Gabriel.png")
const JUSTIN = preload("res://ASSETS/CHARACTERS/NPCS/Justin.png")
const MICKAEL = preload("res://ASSETS/CHARACTERS/NPCS/Mickael.png")
const PANTS = preload("res://ASSETS/CHARACTERS/NPCS/Pants.png")
const SOPHIA = preload("res://ASSETS/CHARACTERS/NPCS/Sophia.png")
const WHIZZY = preload("res://ASSETS/CHARACTERS/NPCS/Whizzy.png")

# button themes
const DIALOGUE_BUTTON_THEME = preload("res://THEMES/dialogue_button_theme.tres")

func _ready(): 
	ui.visible = false

func show_dialogue(speaker, speaking, text, options):
	ui.visible = true
	
	# populate data
	set_sprite(speaker)
	highlight_speaker(speaker, speaking)
	speaker_name.text = speaker
	dialogue_text.text = text
	
	# remove exisiting options
	for option in dialogue_options.get_children():
		dialogue_options.remove_child(option)
		
	# populate options
	for option in options.keys():
		var button = Button.new()
		button.text = option
		button.pressed.connect(_on_option_selected.bind(option))
		
		
		# theme
		button.set_theme(DIALOGUE_BUTTON_THEME)
		button.add_theme_color_override("font_color", Color.BLACK)
		button.add_theme_color_override("font_focus_color", Color.BLACK)
		button.add_theme_color_override("font_normal_color", Color.BLACK)
		button.add_theme_color_override("font_pressed_color", Color.BLACK)
		button.add_theme_color_override("font_hover_color", Color.BLACK)
		
		dialogue_options.add_child(button)

func _on_option_selected(option):
	Audio.play_page_flip_sfx()
	get_parent().handle_dialogue_option(option)

func hide_dialogue():
	ui.visible = false
	Global.player.can_move = true

func highlight_speaker(npc, speaking):
	if speaking == npc: # if the currently speaking character is the npc, highlight the npc
		brighten_sprite(npc_sprite)
		darken_sprite(dash_sprite)
	else: # otherwise, highlight Dash
		brighten_sprite(dash_sprite)
		darken_sprite(npc_sprite)

func darken_sprite(sprite):
	sprite.material.set_shader_parameter("value_mult", 0.2)

func brighten_sprite(sprite):
	sprite.material.set_shader_parameter("value_mult", 1.0)
	
# set the texture of the npc
func set_sprite(npc):
	match npc:
		"Laura":
			npc_sprite.texture = LAURA
		"Gab":
			npc_sprite.texture = GAB
		"Justin":
			npc_sprite.texture = JUSTIN
		"Mickael":
			npc_sprite.texture = MICKAEL
		"Pants":
			npc_sprite.texture = PANTS
		"Sophia":
			npc_sprite.texture = SOPHIA
		"Gabriel":
			npc_sprite.texture = GABRIEL
		"Whizzy":
			npc_sprite.texture = WHIZZY
