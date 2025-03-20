extends Node2D

var selected = false
var rest_point: Vector2
var rest_nodes = []  
@export var correct_bin: Node2D  

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")

	if rest_nodes.size() > 0:
		rest_point = rest_nodes[0].global_position  # Set default rest point
	else:
		rest_point = global_position  # Use object's current position as fallback

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected = true 

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, rest_point, 15 * delta)
		rotation = lerp_angle(rotation, 0, 10 * delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and selected:
		selected = false  # Stop dragging
		var shortest_dist = 75
		var closest_bin = null

		for bin in rest_nodes:
			var distance = global_position.distance_to(bin.global_position)
			if distance < shortest_dist:
				shortest_dist = distance
				closest_bin = bin

		if closest_bin:
			rest_point = closest_bin.global_position
			check_correctness(closest_bin)

var already_scored = false  # Prevent multiple scoring

func check_correctness(bin):
	if already_scored:
		return
		already_scored = true
		
	if bin == correct_bin:
		GlobalScore.add_score()
	
	disappear()  # Always disappear, even if incorrect

func disappear():
	await get_tree().create_timer(0.5).timeout  # Delay for effect
	
	if get_parent().has_method("on_node_placed"):
		get_parent().on_node_placed()  # Notify the parent to show the next node
		queue_free()  # Removes the item
