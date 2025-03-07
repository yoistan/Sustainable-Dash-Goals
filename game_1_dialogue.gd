extends CanvasLayer

const CHAR_READ_RATE = 0.3

signal dialogue_queue_finished

# initiate variables
@onready var textbox_container = $TextBoxContainer
@onready var speaker_name = $TextBoxContainer/MarginContainer2/SpeakerName
@onready var dialogue_label = $TextBoxContainer/MarginContainer/RichTextLabel

# initiate tween variable for text animation
var tween

# list of states
enum State {
	WAITING,
	START,
	READY,
	READING,
	FINISHED,
	END,
	STOP
}

# default state
var current_state = State.START

# queue of dialogue
var text_queue = []

func _ready():
	# add dialogue here
	queue_text("Laura", "Hmm, what should I do with all this?")
	queue_text("Dash", "Hello, Laura! Woah, are those props from last semester’s stage play?")
	queue_text("Laura", "Oh, hi Dash! Yes, these are some leftover props from the stage play but no one claimed them.")
	queue_text("Laura", "I’m thinking of organizing them based on whether the prop item can be segregated, recycled, or has to be thrown away.")
	queue_text("Dash", "Why go through all that trouble? When you can just throw everything away at once?")
	queue_text("Laura", "That’ll only end up harming our environment if you don’t properly dispose of your waste items.")
	queue_text("Laura", "Besides, doing this helps you practice SDG 13 as well as reducing the impact of climate change!")
	queue_text("Dash", "Guess that makes sense. C’mon then, these props won’t segregate all by themselves!")

func _process(delta):
	match current_state:
		State.WAITING:
			pass
		State.START: # if it's the first dialogue, play textbox animation and switch to display the text
			show_textbox()
			change_state(State.READY)
		State.READY:
			if !text_queue.is_empty(): # if text queue still has dialogue, display it
				display_text()
			else: # otherwise, change the state to END to play the dialogue end animation
				change_state(State.END)
		State.READING: # if player clicks next while the text is displaying, interrupt the animation
			if Input.is_action_just_pressed("interact"):
				dialogue_label.visible_ratio = 1
				tween.stop()
				change_state(State.FINISHED)
		State.FINISHED: # text is finished animating. if the player taps next, display the next dialogue
			if Input.is_action_just_pressed("interact"):
				change_state(State.READY)
		State.END: # play the dialogue end animation then switch to the final state
			hide_textbox()
			dialogue_queue_finished.emit()
			change_state(State.STOP)
		State.STOP:
			pass

# add dialogue to the queue
func queue_text(character, next_text):
	text_queue.push_back([character, next_text])

# show and hide textbox animations
func show_textbox():
	$DialogueBoxAnimation.play("dialogue_box_enter")
	$TextBoxTimer.start()

func hide_textbox():
	$DialogueBoxAnimation.play("dialogue_box_exit")
	$TextBoxTimer.start()

func display_text():
	# create the tween
	tween = get_tree().create_tween()
	
	# get the next dialogue
	var next_text = text_queue.pop_front()
	
	# change the state to animating the text
	change_state(State.READING)
	
	# set the text
	speaker_name.text = next_text[0]
	dialogue_label.text = next_text[1]
	
	# set the visible ratio to 0 to animate it with tween
	dialogue_label.visible_ratio = 0
	tween.tween_property(dialogue_label, "visible_ratio", 1, len(next_text) * CHAR_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	# change the state to finished after the aniamtion is complete
	tween.tween_callback(next_dialogue)

func next_dialogue():
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state

# 
func _on_hide_text_box_timer_timeout():
	# when there is no dialogue AND it is the end, remove the text and hide
	if text_queue.is_empty() and current_state == State.END:
		speaker_name.text = ""
		dialogue_label.text = ""
		textbox_container.hide()
	
	# when there is still dialogue AND it is the start, show the textbox
	elif !text_queue.is_empty() and current_state == State.START:
		textbox_container.show()


func _on_visibility_changed():
	change_state(State.START)
