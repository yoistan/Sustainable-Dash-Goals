### dialogue_ui.gd

extends Control

@onready var ui = $CanvasLayer
@onready var speaker_name = $CanvasLayer/TextBoxContainer/speaker/SpeakerName
@onready var dialogue_text = $CanvasLayer/TextBoxContainer/text/DialogueText
@onready var dialogue_options = $CanvasLayer/TextBoxContainer/options/dialogueOptions

func _ready():
	ui.visible = false

func show_dialogue(speaker, text, options):
	ui.visible = true
	
	# populate data
	speaker_name.text = speaker
	dialogue_text.text = text
	
	# remove exisiting options
	for option in dialogue_options.get_children():
		dialogue_options.remove_child(option)
		
	# populate options
	for option in options.keys():
		var button = Button.new()
		button.text = option
		button.add_theme_font_size_override("font_size", 5)
		button.pressed.connect(_on_option_selected.bind(option))
		dialogue_options.add_child(button)

func _on_option_selected(option):
	get_parent().handle_dialogue_option(option)

func hide_dialogue():
	ui.visible = false
	Global.player.can_move = true
