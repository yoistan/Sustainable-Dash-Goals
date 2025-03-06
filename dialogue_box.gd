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
var current_state = State.WAITING

# queue of dialogue
var text_queue = []

func _ready():
	# add dialogue here
	queue_text("Whizzy", "Good morning, Dash! You’re early today. Got any plans?")
	queue_text("Dash", "Good morning, Whizzy! Yeah, I’m locking in this semester. I’m gonna study at CLIR.")
	queue_text("Whizzy", "Locking in?")
	queue_text("Dash", "It means I’ll be focused this semester, in this case, with my acads.")
	queue_text("Whizzy", "Ahhh! I understand. That’s something new to my vocabulary, haha!")
	queue_text("Whizzy", "Well then, I’ll also be locking in on studying the arts of Wizardry. See you and good luck, Dash!")
	queue_text("Dash", "Thanks, Whizzy, you too!")

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
